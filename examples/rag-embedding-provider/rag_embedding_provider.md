# Embeddings with a specific embedding provider

An embedding provider (`ai:EmbeddingProvider`) converts text chunks into vector embeddings, so that semantically similar text can be found using vector similarity search. Embedding providers are used in retrieval-augmented generation (RAG) both when ingesting documents and when retrieving relevant chunks for a query.

The `ai:EmbeddingProvider` type is a unified abstraction implemented by provider-specific modules such as [ballerinax/ai.openai](https://central.ballerina.io/ballerinax/ai.openai/latest) and [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest), so the same code works across providers. The default embedding provider (`ai:getDefaultEmbeddingProvider()`) can be used without managing keys.

This example demonstrates how to initialize a specific embedding provider with your own API key, embed single and multiple chunks, compare embeddings, and use the provider with a knowledge base.

> Note: Add the API key to the `Config.toml` file (e.g., `openAiApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_embedding_provider.bal :::

::: out rag_embedding_provider.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
