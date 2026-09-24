# RAG with Azure AI Search knowledge base

In addition to the vector store-based `ai:VectorKnowledgeBase`, Ballerina provides knowledge bases backed by managed search services. The [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) module provides `azure:AiSearchKnowledgeBase`, an `ai:KnowledgeBase` implementation backed by [Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/ai-search), which stores the chunks and their embeddings in a search index and retrieves them with vector search.

The knowledge base can be created for an existing index by passing the index name, or for a new index by passing a `search:SearchIndex` definition, which creates the index. The index must have a key field of type string, a content field (named `content` by default), and a vector field whose dimension matches the embedding model.

This example demonstrates creating a knowledge base with a new index definition, ingesting documents, then accessing the same index as an existing index to retrieve chunks and answer a question. Azure OpenAI is used for the embeddings and the final response.

> Note: Create an [Azure AI Search](https://learn.microsoft.com/en-us/azure/search/search-create-service-portal) service and an Azure OpenAI resource with chat and embedding deployments, and add the values to the `Config.toml` file (e.g., `searchServiceUrl = "https://<service>.search.windows.net"`, `searchApiKey = "<admin-key>"`, `openAiServiceUrl = "https://<resource>.services.ai.azure.com/openai/v1"`, `openAiApiKey = "<api-key>"`, `chatDeploymentId = "<deployment>"`, `embeddingDeploymentId = "<deployment>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_azure_ai_search_knowledge_base.bal :::

::: out rag_with_azure_ai_search_knowledge_base.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The Custom knowledge base example](/learn/by-example/rag-custom-knowledge-base/)
- [The `ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest)
- [The `ballerinax/azure.ai.search` module](https://central.ballerina.io/ballerinax/azure.ai.search/latest)
