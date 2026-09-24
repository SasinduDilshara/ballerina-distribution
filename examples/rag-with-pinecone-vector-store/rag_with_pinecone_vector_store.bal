import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;
import ballerinax/ai.pinecone;

// Configuration for Pinecone and OpenAI.
configurable string pineconeServiceUrl = ?;
configurable string pineconeApiKey = ?;
configurable string openAiApiKey = ?;

// Define the vector store to use. The example uses Pinecone, a managed vector database.
// Alternatively, you can use other providers (e.g., pgvector, Milvus, Weaviate)
// or the in-memory vector store (`ai:InMemoryVectorStore`).
final ai:VectorStore vectorStore = check new pinecone:VectorStore(pineconeServiceUrl, pineconeApiKey);

// Define the embedding provider to use. The example uses the OpenAI embedding provider.
// The dimension of the Pinecone index must match the embedding model (1536 for this model).
final ai:EmbeddingProvider embeddingProvider =
        check new openai:EmbeddingProvider(openAiApiKey, openai:TEXT_EMBEDDING_3_SMALL);

// Use the default model provider to generate the final response.
final ai:ModelProvider model = check ai:getDefaultModelProvider();

// Create the knowledge base with the vector store and embedding provider.
// The chunker argument is optional and defaults to `ai:AUTO`, which selects a chunker based
// on the type of each ingested document (e.g., Markdown, HTML, or generic text). Pass a specific
// `ai:Chunker` for finer control, or `ai:DISABLE` to store each document as a single chunk.
final ai:KnowledgeBase knowledgeBase = new ai:VectorKnowledgeBase(vectorStore, embeddingProvider, ai:AUTO);

public function main() returns error? {
    // Ingest a Markdown document into the knowledge base. With `ai:AUTO`, the document is
    // chunked by its Markdown structure, and the chunks are embedded and stored in Pinecone.
    ai:TextDocument policy = {
        metadata: {fileName: "leave_policy.md", mimeType: "text/markdown"},
        content: string `# Leave policy

## Annual leave

Full-time employees are entitled to 20 days of paid annual leave per year.

## Sick leave

Employees are entitled to 10 days of paid sick leave per year.

## Parental leave

Parental leave is 12 weeks and must be requested one month in advance.`
    };
    check knowledgeBase.ingest(policy);
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
