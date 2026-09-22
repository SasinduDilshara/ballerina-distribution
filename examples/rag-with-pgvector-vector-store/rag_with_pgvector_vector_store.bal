import ballerina/ai;
import ballerina/io;
import ballerinax/ai.pgvector;

// Configuration for the PostgreSQL database with the pgvector extension.
configurable string pgHost = "localhost";
configurable int pgPort = 5432;
configurable string pgUser = "postgres";
configurable string pgPassword = ?;
configurable string pgDatabase = "vector_db";

// Define the vector store to use. The example uses pgvector, a PostgreSQL extension
// for vector similarity search. The table is created if it does not exist.
// Alternatively, you can use other providers (e.g., Milvus, Pinecone, Weaviate)
// or the in-memory vector store (`ai:InMemoryVectorStore`).
final ai:VectorStore vectorStore = check new pgvector:VectorStore(pgHost, pgUser, pgPassword,
        pgDatabase, tableName = "leave_policy_vectors", port = pgPort,
        // The vector dimension must match the embedding provider used.
        configs = {vectorDimension: 1536});

// Define the embedding provider to use.
// The example uses the default embedding provider implementation
// (with configuration added via a Ballerina VS Code command).
final ai:EmbeddingProvider embeddingProvider = check ai:getDefaultEmbeddingProvider();

// Use the default model provider to generate the final response.
final ai:ModelProvider model = check ai:getDefaultModelProvider();

// Create the knowledge base with the vector store and embedding provider.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider);

public function main() returns error? {
    // Ingest documents into the knowledge base. The chunks are embedded and
    // stored in the PostgreSQL table.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");

    // Retrieve the most relevant chunks for a query using vector similarity search.
    string query = "How much paid vacation do I get?";
    ai:QueryMatch[] matches = check knowledgeBase.retrieve(query, 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the user query with the retrieved context and generate the response.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response?.content);
}
