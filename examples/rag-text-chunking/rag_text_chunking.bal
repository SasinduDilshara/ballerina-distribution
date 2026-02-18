import ballerina/ai;
import ballerina/io;

// Define an in-memory vector store for storing chunked embeddings.
final ai:VectorStore vectorStore = check new ai:InMemoryVectorStore();

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Create a GenericRecursiveChunker to split plain text into overlapping chunks.
// - maxChunkSize: maximum number of characters per chunk (default: 200)
// - maxOverlapSize: overlap between adjacent chunks to preserve context (default: 40)
// The chunker tries to split at paragraph boundaries first, then falls back to
// sentence, word, and character boundaries.
final ai:GenericRecursiveChunker chunker = new (maxChunkSize = 300, maxOverlapSize = 50);

// Build a knowledge base with the explicit chunker rather than the default AUTO chunker.
// This gives fine-grained control over how the document is split before embedding.
final ai:VectorKnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, chunker);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load a plain-text document using TextDataLoader.
    // TextDataLoader supports .txt, .pdf, .docx, .pptx, .html, and .md files.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.txt");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest the document — the explicit chunker splits the text, the embedding
    // provider converts each chunk to a vector, and the vector store indexes it.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion with text chunking successful");

    // Retrieve the most relevant chunks for a query.
    string query = "How many sick leave days are employees entitled to per year?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with the retrieved context and ask the model.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
