import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// Configure Azure OpenAI connection details via Config.toml.
// The embedding model is deployed separately from the chat model in Azure.
configurable string serviceUrl = ?;
configurable string accessToken = ?;
configurable string apiVersion = ?;
configurable string deploymentId = ?;

// Initialize the Azure OpenAI embedding provider.
// The deploymentId refers to the embedding model deployment (e.g., text-embedding-3-small).
final azure:EmbeddingProvider embedder = check new (serviceUrl, accessToken, apiVersion, deploymentId);

// Compute dot product similarity between two unit-normalized embedding vectors.
// Azure OpenAI embeddings are unit-normalized, so dot product equals cosine similarity.
function similarity(float[] a, float[] b) returns float {
    float result = 0.0;
    foreach int i in 0 ..< a.length() {
        result += a[i] * b[i];
    }
    return result;
}

public function main() returns error? {
    // Support ticket to find the most relevant FAQ entry for.
    ai:TextChunk ticketChunk = {content: "My invoice shows an incorrect billing amount."};

    // FAQ entries to compare against the ticket.
    ai:TextChunk[] faqChunks = [
        {content: "How to dispute a billing error or incorrect charge"},
        {content: "How to update your payment method"},
        {content: "How to download your invoice as a PDF"}
    ];

    // Embed the support ticket.
    ai:Embedding ticketEmbedding = check embedder->embed(ticketChunk);
    float[] ticketVec = check ticketEmbedding.cloneWithType();

    // Embed all FAQ entries in a single batch call.
    ai:Embedding[] faqEmbeddings = check embedder->batchEmbed(faqChunks);

    // Find the FAQ entry most semantically similar to the ticket.
    int bestIndex = 0;
    float bestScore = -1.0;
    foreach int i in 0 ..< faqChunks.length() {
        float[] faqVec = check faqEmbeddings[i].cloneWithType();
        float score = similarity(ticketVec, faqVec);
        io:println(string `  "${faqChunks[i].content}": ${score}`);
        if score > bestScore {
            bestScore = score;
            bestIndex = i;
        }
    }

    io:println("Best matching FAQ: \"", faqChunks[bestIndex].content, "\"");
}
