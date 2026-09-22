import ballerina/ai;
import ballerina/io;

// A custom knowledge base that implements the `ai:KnowledgeBase` type.
// Instead of vector similarity, this implementation ranks chunks by keyword overlap.
// The same approach can be used to integrate any search backend (e.g., a full-text
// search engine or an existing enterprise search API) into a RAG workflow.
isolated class KeywordKnowledgeBase {
    *ai:KnowledgeBase;

    private final ai:TextChunk[] chunks = [];

    // Ingests documents or chunks. Documents are split into paragraphs here;
    // an `ai:Chunker` can be used instead for finer control.
    public isolated function ingest(ai:Chunk[]|ai:Document[]|ai:Document documents) returns ai:Error? {
        ai:Document[] items;
        if documents is ai:Document {
            items = [documents];
        } else {
            items = documents;
        }
        foreach ai:Document item in items {
            if item is ai:TextChunk {
                lock {
                    self.chunks.push(item.clone());
                }
            } else if item is ai:TextDocument {
                foreach string paragraph in re `\n\s*\n`.split(item.content) {
                    ai:TextChunk chunk = {content: paragraph.trim(), metadata: item.metadata};
                    lock {
                        self.chunks.push(chunk.clone());
                    }
                }
            } else {
                return error ai:Error("Only text documents and text chunks are supported");
            }
        }
    }

    // Retrieves the chunks that share the most keywords with the query.
    public isolated function retrieve(string query, int maxLimit, ai:MetadataFilters? filters = ())
            returns ai:QueryMatch[]|ai:Error {
        readonly & string[] queryWords = tokenize(query).cloneReadOnly();
        ai:QueryMatch[] matches;
        lock {
            ai:QueryMatch[] found = [];
            foreach ai:TextChunk chunk in self.chunks {
                int overlap = countOverlap(queryWords, tokenize(chunk.content));
                if overlap > 0 {
                    float similarityScore = <float>overlap / <float>queryWords.length();
                    found.push({chunk: chunk.clone(), similarityScore});
                }
            }
            matches = found.clone();
        }
        return from ai:QueryMatch queryMatch in matches
            order by queryMatch.similarityScore descending
            limit maxLimit
            select queryMatch;
    }

    // Deletes chunks whose metadata matches the given filters.
    public isolated function deleteByFilter(ai:MetadataFilters filters) returns ai:Error? {
        readonly & ai:MetadataFilters readonlyFilters = filters.cloneReadOnly();
        lock {
            ai:TextChunk[] remaining = [];
            foreach ai:TextChunk chunk in self.chunks {
                if !matchesFilters(chunk, readonlyFilters) {
                    remaining.push(chunk);
                }
            }
            self.chunks.removeAll();
            self.chunks.push(...remaining);
        }
    }
}

isolated function countOverlap(string[] queryWords, string[] chunkWords) returns int {
    int overlap = 0;
    foreach string word in queryWords {
        if chunkWords.indexOf(word) != () {
            overlap += 1;
        }
    }
    return overlap;
}

isolated function tokenize(string text) returns string[] =>
    re `[^a-zA-Z0-9]+`.split(text.toLowerAscii()).filter(word => word.length() > 2);

// Supports equality filters combined with the `ai:AND` condition.
isolated function matchesFilters(ai:TextChunk chunk, ai:MetadataFilters filters) returns boolean {
    ai:Metadata metadata = chunk.metadata ?: {};
    foreach ai:MetadataFilters|ai:MetadataFilter filter in filters.filters {
        if filter is ai:MetadataFilter {
            if metadata[filter.key] != filter.value {
                return false;
            }
        } else if !matchesFilters(chunk, filter) {
            return false;
        }
    }
    return true;
}

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

public function main() returns error? {
    // The custom implementation is used through the `ai:KnowledgeBase` type,
    // so the rest of the RAG workflow does not depend on the implementation.
    ai:KnowledgeBase knowledgeBase = new KeywordKnowledgeBase();
    ai:TextDocument policy = {
        metadata: {fileName: "leave_policy.md"},
        content: string `Full-time employees are entitled to 20 days of paid annual leave per year.

            Employees are entitled to 10 days of paid sick leave per year. A medical
            certificate is required for absences longer than two consecutive days.

            Parental leave is 12 weeks and must be requested one month in advance.`
    };
    check knowledgeBase.ingest(policy);

    string query = "How many sick leave days do employees get?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the query with the retrieved context and generate the response.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response?.content);
}
