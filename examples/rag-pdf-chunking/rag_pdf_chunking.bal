import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store for storing chunked embeddings.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create a GenericRecursiveChunker to split the text extracted from the PDF.
// TextDataLoader extracts plain text from the PDF; GenericRecursiveChunker then
// splits that text at paragraph boundaries, falling back to sentence, word, and
// character boundaries. The overlap preserves context across chunk boundaries.
final ai:GenericRecursiveChunker chunker = new (maxChunkSize = 300, maxOverlapSize = 50);

// Build a knowledge base using the explicit chunker instead of the default AUTO chunker.
// This gives fine-grained control over how the extracted PDF text is split before embedding.
final ai:VectorKnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, chunker);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load a PDF document using TextDataLoader.
    // TextDataLoader detects the .pdf extension, extracts the text content from
    // the PDF pages, and returns it as an ai:Document ready for chunking.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.pdf");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: GenericRecursiveChunker splits the extracted PDF text, the embedding
    // provider converts each chunk to a vector, and the vector store indexes it.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion with PDF chunking successful");

    // Query: retrieve the most relevant chunks for the question.
    string query = "What is the procedure for requesting annual leave?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with the retrieved context and ask the model.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
