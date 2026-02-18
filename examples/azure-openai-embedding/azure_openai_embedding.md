# Azure OpenAI model provider — Embedding API

The [`ballerinax/ai.azure`](https://central.ballerina.io/ballerinax/ai.azure/latest) module provides an `azure:EmbeddingProvider` client that generates text embeddings using Azure-hosted OpenAI embedding models. Embeddings convert text into dense numeric vectors that capture semantic meaning, enabling applications like semantic search, FAQ routing, document clustering, and retrieval-augmented generation (RAG).

The `embed` method generates an embedding for a single text chunk, while `batchEmbed` processes multiple chunks in one call for better throughput. In Azure, embedding models are deployed separately from chat models and are identified by a deployment ID. Azure hosting provides the same compliance and data-residency guarantees as for chat models.

This example demonstrates semantic FAQ routing: it finds the most relevant FAQ article for a support ticket by comparing the ticket's embedding against a set of FAQ embeddings using dot product similarity.

> Note: Set `serviceUrl`, `accessToken`, `apiVersion`, and `deploymentId` in the `Config.toml` file with your Azure OpenAI embedding deployment details before running this example.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code azure_openai_embedding.bal :::

::: out azure_openai_embedding.out :::

## Related links
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [Azure OpenAI Chat API example](/learn/by-example/azure-openai-chat/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Azure OpenAI embeddings documentation](https://learn.microsoft.com/azure/ai-services/openai/how-to/embeddings)
