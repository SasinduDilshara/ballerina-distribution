# RAG ingestion with Azure AI Search

[Azure AI Search](https://learn.microsoft.com/azure/search/search-what-is-azure-search) is a managed cloud search service that provides vector search, full-text search, and hybrid search capabilities. The [`ballerinax/ai.azure`](https://central.ballerina.io/ballerinax/ai.azure/latest) module's `azure:AiSearchKnowledgeBase` integrates Azure AI Search as a RAG knowledge base: it creates or reuses a search index, chunks and embeds incoming documents using an Azure OpenAI embedding model, and uploads the resulting vectors and text into the index.

Using Azure AI Search as a RAG backend is well-suited for enterprise environments that already use Azure infrastructure: the search index supports role-based access control, private endpoints, and seamless integration with Azure OpenAI, making it a natural choice for secure, compliant RAG systems.

This example demonstrates the ingestion phase: loading a Markdown leave policy document, embedding it with Azure OpenAI, and indexing it into an Azure AI Search index. The corresponding query example is shown in [RAG query with Azure AI Search](/learn/by-example/rag-query-with-azure-ai-search/).

> Note: Set `azureOpenAiServiceUrl`, `azureOpenAiAccessToken`, `azureOpenAiApiVersion`, `embeddingDeploymentId`, `azureSearchServiceUrl`, `azureSearchApiKey`, and `azureSearchIndexName` in the `Config.toml` file with your Azure resource details. The index is created automatically if it does not exist.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_ingestion_with_azure_ai_search.bal :::

::: out rag_ingestion_with_azure_ai_search.out :::

## Related links
- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-ingestion-with-azure-ai-search/leave_policy.md)
- [RAG query with Azure AI Search example](/learn/by-example/rag-query-with-azure-ai-search/)
- [RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Azure AI Search documentation](https://learn.microsoft.com/azure/search/)
