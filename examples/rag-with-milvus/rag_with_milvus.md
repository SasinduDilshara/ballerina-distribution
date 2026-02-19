# RAG with Milvus

The [`ballerinax/ai.milvus`](https://central.ballerina.io/ballerinax/ai.milvus/latest) module provides a `milvus:VectorStore` that implements the `ai:VectorStore` interface, enabling Milvus to serve as the vector database backend for Ballerina RAG workflows. Milvus is a high-performance, cloud-native vector database designed for billion-scale similarity search, with support for dense, sparse, and hybrid vector retrieval and flexible schema configuration.

The `milvus:VectorStore` is configured with a collection name, a primary key field, and any additional metadata fields to store alongside the embeddings. By passing it to `ai:VectorKnowledgeBase`, the same high-level RAG API — `ingest`, `retrieve`, `deleteByFilter` — works with Milvus identically to any other vector store.

This example demonstrates a complete RAG workflow using Milvus: ingesting a tech product catalog into a Milvus collection and then answering a natural-language product search query — "What wireless headphones are available under $100?" — from the indexed content.

> Note: This example uses the default embedding provider and model provider. Set `milvusServiceUrl` and `milvusApiKey` in the `Config.toml` file with your Milvus cluster details. To configure the WSO2 default provider, open the VS Code command palette and run the `Configure default WSO2 Model Provider` command.

For more information on the underlying module, see the [`ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest).

::: code rag_with_milvus.bal :::

::: out rag_with_milvus.out :::

## Related links

- [Sample product catalog](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-with-milvus/product_catalog.md)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with Weaviate example](/learn/by-example/rag-with-weaviate/)
- [RAG with pgvector example](/learn/by-example/rag-with-pgvector/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Milvus documentation](https://milvus.io/docs)
