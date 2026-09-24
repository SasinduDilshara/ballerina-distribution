import ballerina/ai;
import ballerina/io;

// Use the default embedding provider (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Define the chunker to use when documents are ingested. Instead of the default `ai:AUTO`
// configuration, which selects a chunker based on the document type, this example uses a
// generic recursive chunker that splits by sentences into chunks of at most 120 characters,
// with an overlap of 20 characters between consecutive chunks to preserve context.
final ai:Chunker chunker = new ai:GenericRecursiveChunker(maxChunkSize = 120, maxOverlapSize = 20,
        strategy = ai:SENTENCE);

// Create the knowledge base with the in-memory vector store, the embedding provider,
// and the custom chunker. Any `ai:Chunker` implementation, including your own, can be used.
final ai:KnowledgeBase knowledgeBase =
        new ai:VectorKnowledgeBase(check new ai:InMemoryVectorStore(), embeddingProvider, chunker);

public function main() returns error? {
    ai:TextDocument policy = {
        metadata: {fileName: "leave_policy.txt"},
        content: string `Full-time employees are entitled to 20 days of paid annual leave per year.
Leave requests must be submitted at least one week in advance.
Employees are entitled to 10 days of paid sick leave per year.
A medical certificate is required for absences longer than two consecutive days.
Parental leave is 12 weeks and must be requested one month in advance.`
    };

    // The document is split by the custom chunker before the chunks are embedded and stored.
    check knowledgeBase.ingest(policy);
    io:println("Ingestion successful");

    // Retrieve the most relevant chunks for a query. The results are the sentence-based
    // chunks produced by the custom chunker.
    ai:QueryMatch[] matches = check knowledgeBase.retrieve("Do I need a medical certificate?", 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }
}
