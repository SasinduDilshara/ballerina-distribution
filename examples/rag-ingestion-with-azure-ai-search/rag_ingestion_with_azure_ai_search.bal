import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// Configure Azure OpenAI and Azure AI Search connection details via Config.toml.
configurable string azureOpenAiServiceUrl = ?;
configurable string azureOpenAiAccessToken = ?;
configurable string azureOpenAiApiVersion = ?;
configurable string embeddingDeploymentId = ?;

configurable string azureSearchServiceUrl = ?;
configurable string azureSearchApiKey = ?;
configurable string azureSearchIndexName = ?;

// Initialize the Azure OpenAI embedding provider.
// Embeddings are used to convert document chunks into vectors for indexing.
final azure:EmbeddingProvider embeddingProvider = check new (
    azureOpenAiServiceUrl, azureOpenAiAccessToken, azureOpenAiApiVersion, embeddingDeploymentId
);

// Initialize the Azure AI Search knowledge base.
// AiSearchKnowledgeBase creates or reuses the specified index in Azure AI Search
// and uses the embedding provider to vectorize documents before indexing them.
final azure:AiSearchKnowledgeBase knowledgeBase = check new (
    azureSearchServiceUrl,
    azureSearchApiKey,
    azureSearchIndexName,
    embeddingModel = embeddingProvider
);

public function main() returns error? {
    // Load the leave policy document using TextDataLoader.
    ai:DataLoader loader = check new ai:TextDataLoader("./leave_policy.md");
    ai:Document|ai:Document[] documents = check loader.load();

    // Ingest: documents are chunked, embedded using Azure OpenAI,
    // and indexed into the Azure AI Search index.
    // Azure AI Search handles both the vector index and the full-text index.
    check knowledgeBase.ingest(documents);
    io:println("Ingestion into Azure AI Search successful");
    io:println("Index: ", azureSearchIndexName);
}
