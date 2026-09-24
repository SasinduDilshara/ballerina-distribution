# Retrieve from a WSO2 Cloud knowledge base

The [ballerinax/ai.wso2.integration](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest) module provides `wso2:CloudKnowledgeBase`, an `ai:KnowledgeBase` implementation backed by a knowledge base hosted on the WSO2 Integration platform. The documents are ingested, chunked, and embedded on the platform, so the application only retrieves from it: the query is embedded by the platform and the matching chunks are returned with their similarity scores. Calls to `ingest` and `deleteByFilter` return an error.

The knowledge base accepts a bearer token or OAuth2 client credentials, drops weak matches below `minSimilarityThreshold`, and can rerank the retrieved chunks with Cohere through the `cohereRerankerApiKey`, `cohereRerankerModel`, and `rerankerTopN` parameters. Since it implements `ai:KnowledgeBase`, the retrieved chunks are used exactly like those from any other knowledge base: augment the prompt with them and generate the answer with a model provider.

This example demonstrates retrieving from a WSO2 Cloud knowledge base and generating the answer with the default WSO2 model provider. To let an agent decide when to retrieve, see the [Agentic RAG with WSO2 Cloud](/learn/by-example/agentic-rag-with-wso2-integration-knowledge-base/) example.

> Note: This example only retrieves. Before you run it, create the knowledge base and ingest your documents on the WSO2 Integration platform. For the platform's generative AI components, including the default WSO2 model provider, see the [WSO2 Integration platform documentation](https://wso2.com/integration-platform/docs/genai/develop/components/model-providers).

> Note: Add the knowledge base URL and token to the `Config.toml` file (e.g., `knowledgeBaseUrl = "<knowledge-base-url>"`, `knowledgeBaseToken = "<token>"`). This example also uses the default model provider implementation. To generate its configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest).

::: code rag_wso2_cloud_knowledge_base_retrieval.bal :::

::: out rag_wso2_cloud_knowledge_base_retrieval.out :::

## Related links

- [The Agentic RAG with WSO2 Cloud example](/learn/by-example/agentic-rag-with-wso2-integration-knowledge-base/)
- [The Retrieve from Azure AI Search example](/learn/by-example/rag-azure-ai-search-retrieval/)
- [The Augment the prompt with retrieved context example](/learn/by-example/rag-augment-prompt/)
- [The `ballerinax/ai.wso2.integration` module](https://central.ballerina.io/ballerinax/ai.wso2.integration/latest)
- [WSO2 Integration platform: Model providers](https://wso2.com/integration-platform/docs/genai/develop/components/model-providers)
