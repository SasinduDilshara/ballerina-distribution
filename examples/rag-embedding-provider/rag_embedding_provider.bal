import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;

// The API key for the embedding provider. Add it to the `Config.toml` file.
configurable string openAiApiKey = ?;

// Initialize an embedding provider for a specific provider using your own API key.
// This example uses OpenAI via the `ballerinax/ai.openai` module. Other providers
// (e.g., `ballerinax/ai.azure`) follow the same pattern and implement the same
// `ai:EmbeddingProvider` type.
final ai:EmbeddingProvider embeddingProvider =
        check new openai:EmbeddingProvider(openAiApiKey, openai:TEXT_EMBEDDING_3_SMALL);

public function main() returns error? {
    // An embedding provider converts a chunk into a vector embedding.
    // Semantically similar text produces vectors that are close to each other.
    ai:TextChunk chunk = {content: "Employees are entitled to 20 days of paid annual leave per year."};
    ai:Embedding embedding = check embeddingProvider->embed(chunk);

    // The provider used in this example returns dense vectors (`ai:Vector`).
    // Some providers also support sparse or hybrid vectors.
    if embedding is ai:Vector {
        io:println("Embedding dimension: ", embedding.length());
    }

    // Use `batchEmbed` to embed multiple chunks in a single request.
    ai:TextChunk[] chunks = [
        {content: "How many days of vacation do I get?"},
        {content: "The quarterly sales report is due on Friday."}
    ];
    ai:Embedding[] embeddings = check embeddingProvider->batchEmbed(chunks);

    // Compare the similarity of each chunk with the first chunk using cosine similarity.
    foreach int i in 0 ..< chunks.length() {
        ai:Embedding other = embeddings[i];
        if embedding is ai:Vector && other is ai:Vector {
            io:println(string `Similarity with "${chunks[i].content}": ${cosineSimilarity(embedding, other)}`);
        }
    }

    // In a RAG workflow, the embedding provider is typically passed to an
    // `ai:VectorKnowledgeBase`, which embeds chunks during ingestion and
    // embeds queries during retrieval.
    ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(check new ai:InMemoryVectorStore(), embeddingProvider);
    check knowledgeBase.ingest(chunks);
    ai:QueryMatch[] matches = check knowledgeBase.retrieve("vacation days", 1);
    io:println("Best match for 'vacation days': ", matches[0].chunk.content);
}

function cosineSimilarity(ai:Vector a, ai:Vector b) returns float {
    float dot = 0.0;
    float normA = 0.0;
    float normB = 0.0;
    foreach int i in 0 ..< a.length() {
        dot += a[i] * b[i];
        normA += a[i] * a[i];
        normB += b[i] * b[i];
    }
    return dot / (normA.sqrt() * normB.sqrt());
}
