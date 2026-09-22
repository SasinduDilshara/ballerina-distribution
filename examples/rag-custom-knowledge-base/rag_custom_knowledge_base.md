# Custom knowledge base

The `ai:KnowledgeBase` type is the abstraction used for ingestion and retrieval in retrieval-augmented generation (RAG) workflows. Ballerina provides the `ai:VectorKnowledgeBase` implementation backed by a vector store and an embedding provider, and modules such as [ballerinax/ai.azure](https://central.ballerina.io/ballerinax/ai.azure/latest) provide implementations backed by managed search services (e.g., Azure AI Search).

You can also implement `ai:KnowledgeBase` yourself to integrate any retrieval backend, such as a full-text search engine, an existing enterprise search API, or a hybrid of keyword and vector search. A custom knowledge base must implement the `ingest`, `retrieve`, and `deleteByFilter` methods. Since the rest of the workflow (e.g., `ai:augmentUserQuery`) only depends on the `ai:KnowledgeBase` type, the implementation can be swapped without changing the application logic.

This example demonstrates a simple keyword-based knowledge base implementation and its use in a RAG workflow.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_custom_knowledge_base.bal :::

::: out rag_custom_knowledge_base.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The Vector search with metadata filters example](/learn/by-example/rag-query-with-metadata-filters/)
- [The `ballerinax/ai.azure` module (Azure AI Search knowledge base)](https://central.ballerina.io/ballerinax/ai.azure/latest)
