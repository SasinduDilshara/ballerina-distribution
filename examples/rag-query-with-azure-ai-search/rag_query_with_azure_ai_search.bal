import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// Configure Azure OpenAI and Azure AI Search connection details via Config.toml.
configurable string azureOpenAiServiceUrl = ?;
configurable string azureOpenAiApiKey = ?;
configurable string azureOpenAiApiVersion = ?;
configurable string chatDeploymentId = ?;
configurable string embeddingDeploymentId = ?;

configurable string azureOpenAiEmbeddingUrl = ?;
configurable string azureOpenAiEmbeddingToken = ?;

configurable string azureSearchServiceUrl = ?;
configurable string azureSearchApiKey = ?;
configurable string azureSearchIndexName = ?;

// Initialize the Azure OpenAI embedding provider for query vectorization.
final azure:EmbeddingProvider embeddingProvider = check new (
    azureOpenAiEmbeddingUrl, azureOpenAiEmbeddingToken, azureOpenAiApiVersion, embeddingDeploymentId
);

// Connect to an existing Azure AI Search index for retrieval.
// The embedding provider is used to vectorize incoming queries before searching.
final azure:AiSearchKnowledgeBase knowledgeBase = check new (
    azureSearchServiceUrl,
    azureSearchApiKey,
    azureSearchIndexName,
    embeddingModel = embeddingProvider
);

// Initialize the Azure OpenAI chat model for answer generation.
final azure:OpenAiModelProvider chatModel = check new (
    azureOpenAiServiceUrl, azureOpenAiApiKey, chatDeploymentId, azureOpenAiApiVersion
);

public function main() returns error? {
    // Query 1: retrieve relevant chunks and generate an answer.
    string query1 = "How many days of bereavement leave are employees entitled to?";
    ai:QueryMatch[] matches1 = check knowledgeBase.retrieve(query1, 5);
    ai:Chunk[] context1 = from ai:QueryMatch match in matches1 select match.chunk;

    ai:ChatUserMessage augmentedQuery1 = ai:augmentUserQuery(context1, query1);
    ai:ChatAssistantMessage answer1 = check chatModel->chat(augmentedQuery1);
    io:println("Query: ", query1);
    io:println("Answer: ", answer1.content);

    // Query 2: demonstrate a second independent question against the same index.
    string query2 = "What notice period is required before taking maternity leave?";
    ai:QueryMatch[] matches2 = check knowledgeBase.retrieve(query2, 5);
    ai:Chunk[] context2 = from ai:QueryMatch match in matches2 select match.chunk;

    ai:ChatUserMessage augmentedQuery2 = ai:augmentUserQuery(context2, query2);
    ai:ChatAssistantMessage answer2 = check chatModel->chat(augmentedQuery2);
    io:println("\nQuery: ", query2);
    io:println("Answer: ", answer2.content);
}
