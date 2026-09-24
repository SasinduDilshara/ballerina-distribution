# RAG with Pinecone vector store

Ballerina provides the `ai:VectorStore` abstraction for persisting and searching vector embeddings, with implementations for external vector databases such as Pinecone, pgvector, Milvus, and Weaviate, in addition to the built-in `ai:InMemoryVectorStore`. Since all implementations share the same type, the vector store can be swapped without changing the rest of the retrieval-augmented generation (RAG) workflow.

This example demonstrates an end-to-end RAG workflow using [Pinecone](https://www.pinecone.io/), a managed vector database, via the [ballerinax/ai.pinecone](https://central.ballerina.io/ballerinax/ai.pinecone/latest) module. A Markdown document is ingested into a knowledge base created with the `ai:AUTO` chunker configuration, which chunks each document based on its type, relevant chunks are retrieved for a query, and the query is augmented with the retrieved context before calling the LLM.

> Note: Follow the [`ballerinax/ai.pinecone` prerequisites](https://central.ballerina.io/ballerinax/ai.pinecone/latest#prerequisites) to create a Pinecone index with the dimension of the embedding model (1536 for `text-embedding-3-small`) and obtain the index host URL and API key, and add them along with the OpenAI API key to the `Config.toml` file (e.g., `pineconeServiceUrl = "<index-host-url>"`, `pineconeApiKey = "<api-key>"`, `openAiApiKey = "<api-key>"`). This example uses the OpenAI embedding provider and the default model provider. To generate the configuration for the default model provider, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_pinecone_vector_store.bal :::

::: out rag_with_pinecone_vector_store.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The RAG with pgvector vector store example](/learn/by-example/rag-with-pgvector-vector-store/)
- [The Document chunking example](/learn/by-example/rag-document-chunking/)
- [The `ballerinax/ai.pinecone` module](https://central.ballerina.io/ballerinax/ai.pinecone/latest)
- [The `ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest)
- [The `ballerinax/ai.milvus` module](https://central.ballerina.io/ballerinax/ai.milvus/latest)
- [The `ballerinax/ai.weaviate` module](https://central.ballerina.io/ballerinax/ai.weaviate/latest)
