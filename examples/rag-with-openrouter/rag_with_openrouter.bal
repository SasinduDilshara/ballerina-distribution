import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openrouter;

// The API key for OpenRouter. Add it to the `Config.toml` file.
configurable string openRouterApiKey = ?;

// OpenRouter provides unified access to models from many providers through a single API.
// Define the embedding provider and the model provider using OpenRouter model identifiers.
final ai:EmbeddingProvider embeddingProvider =
        check new openrouter:EmbeddingProvider(openRouterApiKey, "openai/text-embedding-3-small");
final ai:ModelProvider model = check new openrouter:ModelProvider(openRouterApiKey, "openai/gpt-4o-mini");

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
