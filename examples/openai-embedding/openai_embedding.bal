import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;

// Configure the OpenAI API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the OpenAI embedding provider.
// TEXT_EMBEDDING_3_SMALL is a fast, cost-effective model for semantic similarity tasks.
final openai:EmbeddingProvider embedder = check new (apiKey, openai:TEXT_EMBEDDING_3_SMALL);

// Compute the dot product of two vectors as the similarity score.
// OpenAI embeddings are unit-normalized, so dot product equals cosine similarity.
function similarity(float[] a, float[] b) returns float {
    float result = 0.0;
    foreach int i in 0 ..< a.length() {
        result += a[i] * b[i];
    }
    return result;
}

public function main() returns error? {
    // Define a reference query and candidate sentences to compare against it.
    ai:TextChunk referenceChunk = {content: "How do I reset my password?"};
    ai:TextChunk[] candidateChunks = [
        {content: "Steps to change your account credentials"},
        {content: "What is the weather like today?"},
        {content: "I forgot my login password, how can I recover it?"}
    ];

    // Generate an embedding for the reference query.
    ai:Embedding referenceEmbedding = check embedder->embed(referenceChunk);
    float[] refVec = check referenceEmbedding.cloneWithType();

    // Generate embeddings for all candidates in one batch call.
    ai:Embedding[] candidateEmbeddings = check embedder->batchEmbed(candidateChunks);

    // Compare each candidate against the reference using dot product similarity.
    io:println("Semantic similarity to: \"", referenceChunk.content, "\"");
    io:println("---");
    foreach int i in 0 ..< candidateChunks.length() {
        float[] candidateVec = check candidateEmbeddings[i].cloneWithType();
        float score = similarity(refVec, candidateVec);
        io:println(string `  "${candidateChunks[i].content}": ${score}`);
    }
}
