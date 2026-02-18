# RAG query with Azure AI Search

After documents are ingested into an Azure AI Search index (see [RAG ingestion with Azure AI Search](/learn/by-example/rag-ingestion-with-azure-ai-search/)), the `azure:AiSearchKnowledgeBase` can be used to retrieve semantically relevant chunks at query time. The incoming query is vectorized using the same Azure OpenAI embedding model used during ingestion, and Azure AI Search performs a vector similarity search to return the most relevant document chunks.

The retrieved chunks are then passed to an Azure OpenAI chat model via `ai:augmentUserQuery`, which wraps them in a prompt template that instructs the model to answer based only on the provided context. This pattern — retrieve then generate — is the core of retrieval-augmented generation and ensures answers are grounded in the indexed document content rather than the model's training data.

This example demonstrates querying the Azure AI Search index for answers to two HR policy questions about bereavement leave and maternity leave notice periods.

> Note: Run [RAG ingestion with Azure AI Search](/learn/by-example/rag-ingestion-with-azure-ai-search/) first to populate the index. Set all Azure connection details in the `Config.toml` file before running this example.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code rag_query_with_azure_ai_search.bal :::

::: out rag_query_with_azure_ai_search.out :::

## Related links
- [RAG ingestion with Azure AI Search example](/learn/by-example/rag-ingestion-with-azure-ai-search/)
- [RAG query with external vector store example](/learn/by-example/rag-query-with-external-vector-store/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Azure AI Search documentation](https://learn.microsoft.com/azure/search/)
