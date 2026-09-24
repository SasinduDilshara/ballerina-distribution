import ballerina/ai;
import ballerina/io;
import ballerinax/ai.googleapis.vertex;

// Google Cloud configuration. Add the values to the `Config.toml` file.
configurable string serviceAccountKeyPath = ?;
configurable string projectId = ?;
configurable string location = "us-central1";

// Define the embedding provider and the model provider for Google Vertex AI. The providers
// authenticate with a service account key file (OAuth2 refresh tokens and service account
// credentials are also supported).
final ai:EmbeddingProvider embeddingProvider =
        check new vertex:EmbeddingProvider(serviceAccountKeyPath, projectId, location);
final ai:ModelProvider model =
        check new vertex:ModelProvider(serviceAccountKeyPath, projectId, "google/gemini-2.5-flash", location);

// Create the knowledge base with the in-memory vector store and the embedding provider.
final ai:KnowledgeBase knowledgeBase =
        new ai:VectorKnowledgeBase(check new ai:InMemoryVectorStore(), embeddingProvider);

public function main() returns error? {
    // Ingest the documents into the knowledge base.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check knowledgeBase.ingest(documents);
    io:println("Ingestion successful");

    // Retrieve the most relevant chunks for the query.
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
