import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store for storing chunked embeddings.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create an HtmlChunker that splits HTML documents using the header structure.
// By default it uses HTML_HEADER strategy, splitting at <h1>–<h6> header tags.
// This produces semantically coherent chunks aligned with the page's sections,
// rather than splitting at arbitrary character positions.
final ai:HtmlChunker chunker = new ();

// Build a knowledge base with the explicit HtmlChunker.
final ai:VectorKnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, chunker);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load an HTML document using TextDataLoader.
    // TextDataLoader detects the .html extension and loads it as an HTML document,
    // allowing the HtmlChunker to leverage the tag structure during splitting.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.html");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: the HtmlChunker splits by HTML headers, the embedding provider
    // converts each section to a vector, and the vector store indexes it.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion with HTML chunking successful");

    // Query: retrieve the most relevant HTML sections for the question.
    string query = "Can employees carry forward unused annual leave days?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch match in matches select match.chunk;

    // Augment the query with retrieved context and get an answer from the model.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
