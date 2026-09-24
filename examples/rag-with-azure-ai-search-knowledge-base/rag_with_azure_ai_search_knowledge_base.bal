import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;
import ballerinax/azure.ai.search;

// Azure AI Search and Azure OpenAI configuration. Add the values to the `Config.toml` file.
configurable string searchServiceUrl = ?;
configurable string searchApiKey = ?;
configurable string openAiServiceUrl = ?;
configurable string openAiApiKey = ?;
configurable string chatDeploymentId = ?;
configurable string embeddingDeploymentId = ?;

// Use Azure OpenAI for the embeddings and the final response.
final ai:EmbeddingProvider embeddingProvider =
        check new azure:EmbeddingProvider(openAiServiceUrl, openAiApiKey, (), embeddingDeploymentId);
final ai:ModelProvider model = check new azure:OpenAiModelProvider(openAiServiceUrl, openAiApiKey, chatDeploymentId);

// Definition of a search index with a key field, a content field, and a vector field.
// The dimension of the vector field must match the embedding model (1536 for this model).
final search:SearchIndex hrPoliciesIndex = {
    name: "hr-policies",
    fields: [
        {name: "id", 'type: "Edm.String", 'key: true},
        {name: "content", 'type: "Edm.String", searchable: true},
        {
            name: "contentVector",
            'type: "Collection(Edm.Single)",
            searchable: true,
            dimensions: 1536,
            vectorSearchProfile: "hr-vector-profile"
        }
    ],
    vectorSearch: {
        algorithms: [{name: "hr-hnsw", kind: "hnsw"}],
        profiles: [{name: "hr-vector-profile", algorithm: "hr-hnsw"}]
    }
};

public function main() returns error? {
    // Create a knowledge base backed by a new index. Passing an index definition
    // (`search:SearchIndex`) creates the index (or updates it, if it already exists).
    ai:KnowledgeBase newIndexKnowledgeBase = check new azure:AiSearchKnowledgeBase(searchServiceUrl, searchApiKey,
            hrPoliciesIndex, embeddingProvider);

    // Ingest the documents. The chunks are embedded and uploaded to the index.
    ai:TextDocument[] documents = [
        {content: "Full-time employees are entitled to 20 days of paid annual leave per year."},
        {content: "Employees are entitled to 10 days of paid sick leave per year."},
        {content: "Parental leave is 12 weeks and must be requested one month in advance."}
    ];
    check newIndexKnowledgeBase.ingest(documents);
    io:println("Ingestion successful");

    // Create a knowledge base backed by an existing index by passing the index name.
    // The index must already exist in the Azure AI Search service.
    ai:KnowledgeBase existingIndexKnowledgeBase = check new azure:AiSearchKnowledgeBase(searchServiceUrl,
            searchApiKey, "hr-policies", embeddingProvider);

    // Retrieve the most relevant chunks for the query using vector search.
    string query = "How much paid vacation do I get?";
    ai:QueryMatch[] matches = check existingIndexKnowledgeBase.retrieve(query, 2);
    foreach ai:QueryMatch queryMatch in matches {
        io:println("Match: ", queryMatch.chunk.content, " (score: ", queryMatch.similarityScore, ")");
    }

    // Augment the user query with the retrieved context and generate the response.
    ai:ChatUserMessage augmentedQuery = ai:augmentUserQuery(matches, query);
    ai:ChatAssistantMessage response = check model->chat(augmentedQuery);
    io:println("\nAnswer: ", response?.content);
}
