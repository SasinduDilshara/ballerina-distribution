# RAG with Weaviate

The [`ballerinax/ai.weaviate`](https://central.ballerina.io/ballerinax/ai.weaviate/latest) module provides a `weaviate:VectorStore` that implements the `ai:VectorStore` interface, enabling Weaviate to serve as the vector database backend for Ballerina RAG workflows. Weaviate is a cloud-native, open-source vector database with built-in vectorization, multi-tenancy, and hybrid search capabilities, making it a popular choice for production RAG systems.

By passing a `weaviate:VectorStore` to `ai:VectorKnowledgeBase`, the same high-level RAG API — `ingest`, `retrieve`, `deleteByFilter` — works with Weaviate identically to any other vector store. Documents are chunked, embedded, and indexed into the configured Weaviate collection during ingestion, and semantically similar chunks are retrieved during query time.

This example demonstrates a complete RAG workflow using Weaviate: ingesting a Markdown leave policy document into a Weaviate collection and then answering a question about maternity leave entitlements from the indexed content.

> Note: This example uses the default embedding provider and model provider. Set `weaviateServiceUrl` and `weaviateApiKey` in the `Config.toml` file with your Weaviate cluster details. To configure the WSO2 default provider, open the VS Code command palette and run the `Configure default WSO2 Model Provider` command.

For more information on the underlying module, see the [`ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest).

::: code rag_with_weaviate.bal :::

::: out rag_with_weaviate.out :::

## Related links
- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-with-weaviate/leave_policy.md)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with Milvus example](/learn/by-example/rag-with-milvus/)
- [RAG with pgvector example](/learn/by-example/rag-with-pgvector/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Weaviate documentation](https://weaviate.io/developers/weaviate)
