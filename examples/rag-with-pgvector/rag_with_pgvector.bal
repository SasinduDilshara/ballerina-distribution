import ballerina/ai;
import ballerina/io;
import ballerinax/ai.pgvector;

// Configure PostgreSQL connection details via Config.toml.
configurable string dbHost = ?;
configurable string dbUser = ?;
configurable string dbPassword = ?;
configurable string dbName = ?;

// Define a pgvector vector store backed by a PostgreSQL database.
// The `tableName` parameter specifies the table that will hold the vector embeddings.
// The table is created automatically on first use if it does not exist.
final ai:VectorStore vectorStore = check new pgvector:VectorStore(
    dbHost,
    dbUser,
    dbPassword,
    dbName,
    tableName = "leave_policy_chunks"
);

// Use the default embedding provider (configured via VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Build a knowledge base backed by the pgvector vector store.
final ai:KnowledgeBase knowledgeBase =
    new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

// Use the default model provider for generating answers.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

public function main() returns error? {
    // Load the leave policy document using TextDataLoader.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: documents are chunked, embedded, and stored in the PostgreSQL table.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion into PostgreSQL (pgvector) successful");

    // Query: retrieve semantically relevant chunks from the pgvector table.
    string query = "What happens to unused annual leave at the end of the year?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 5);
    ai:Chunk[] context = from ai:QueryMatch m in matches select m.chunk;

    // Augment the query with the retrieved context and generate an answer.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(context, query);
    ai:ChatAssistantMessage answer = check modelProvider->chat(augmentedQuery);

    io:println("\nQuery: ", query);
    io:println("Answer: ", answer.content);
}
