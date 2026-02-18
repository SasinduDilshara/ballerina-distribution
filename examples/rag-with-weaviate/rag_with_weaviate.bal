import ballerina/ai;
import ballerina/io;
import ballerinax/ai.weaviate;

// Configure Weaviate connection details via Config.toml.
configurable string weaviateServiceUrl = ?;
configurable string weaviateApiKey = ?;

// Define a Weaviate vector store.
// The Configuration specifies the collection name to use in Weaviate.
final ai:VectorStore vectorStore = check new weaviate:VectorStore(
    weaviateServiceUrl,
    weaviateApiKey,
    {collectionName: "LeavePolicyChunks"}
);

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Build a knowledge base backed by the Weaviate vector store.
final ai:KnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load the leave policy document using TextDataLoader.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: documents are chunked, embedded, and stored in the Weaviate collection.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion into Weaviate successful");

    // Query: retrieve relevant chunks from Weaviate using semantic search.
    string query = "How many days of maternity leave is an employee entitled to?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with the retrieved context and generate an answer.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
