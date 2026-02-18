import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store for storing chunked embeddings.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create a MarkdownChunker that splits Markdown documents by header structure.
// By default it uses MARKDOWN_HEADER strategy, splitting at ## headers first,
// then falling back to ### headers, code blocks, horizontal lines, and paragraphs.
// This preserves the semantic meaning of each Markdown section as a distinct chunk.
final ai:MarkdownChunker chunker = new ();

// Build a knowledge base using the explicit MarkdownChunker.
final ai:VectorKnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, chunker);

// Use the default model provider for answering questions.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load a Markdown document using TextDataLoader.
    // TextDataLoader detects the .md extension and loads it as a Markdown document,
    // allowing the MarkdownChunker to leverage the header structure during splitting.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: the MarkdownChunker splits by headers, the embedding provider converts
    // each section to a vector, and the vector store indexes it.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion with Markdown chunking successful");

    // Query: retrieve the most relevant Markdown sections for the question.
    string query = "What is the procedure for requesting leave?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with retrieved context and get an answer from the model.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
