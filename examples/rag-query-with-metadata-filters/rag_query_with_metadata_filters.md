# Vector search with metadata filters

Chunks stored in a knowledge base carry metadata (`ai:Metadata`), which includes predefined fields such as the file name and chunk index as well as arbitrary custom fields. Metadata filters (`ai:MetadataFilters`) allow you to combine vector similarity search with exact conditions on the metadata, for example, to restrict retrieval to a specific department, document, or time range. This improves precision and enables multi-tenant scenarios where each query must only see a subset of the data.

Filters are expressed using `ai:MetadataFilter` values, each with a key, an operator (`ai:EQUAL`, `ai:NOT_EQUAL`, `ai:GREATER_THAN`, `ai:LESS_THAN`, `ai:GREATER_THAN_OR_EQUAL`, `ai:LESS_THAN_OR_EQUAL`, `ai:IN`, `ai:NOT_IN`), and a value. Multiple filters can be combined with `ai:AND` or `ai:OR` conditions and nested. The same filters can be used with the `deleteByFilter` method to remove chunks from a knowledge base.

This example demonstrates how to ingest chunks with custom metadata, retrieve with and without filters, combine multiple filters, and delete chunks by filter.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_query_with_metadata_filters.bal :::

::: out rag_query_with_metadata_filters.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG query with external vector store example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Document chunking example](/learn/by-example/rag-document-chunking/)
