import ballerina/ai;
import ballerina/io;
import ballerinax/ai.milvus;

// Configure Milvus connection details via Config.toml.
configurable string milvusServiceUrl = ?;
configurable string milvusApiKey = ?;

// Define a Milvus vector store.
// The Configuration specifies the collection name, primary key field, and
// any additional fields to store alongside the vector embeddings.
final ai:VectorStore vectorStore = check new milvus:VectorStore(
    milvusServiceUrl,
    milvusApiKey,
    {
        collectionName: "LeavePolicyChunks",
        primaryKeyField: "id",
        additionalFields: ["content", "source"]
    }
);

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Build a knowledge base backed by the Milvus vector store.
final ai:KnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load the leave policy document using TextDataLoader.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: documents are chunked, embedded, and stored in the Milvus collection.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion into Milvus successful");

    // Query: retrieve semantically relevant chunks from Milvus.
    string query = "What are the rules for casual leave?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with the retrieved context and generate an answer.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
