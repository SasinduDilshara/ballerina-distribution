# Filter results by metadata

Chunks stored in a knowledge base carry metadata (`ai:Metadata`) with predefined fields, such as the file name and chunk index, and arbitrary custom fields. Metadata filters (`ai:MetadataFilters`) combine vector similarity search with exact conditions on this metadata, for example, to restrict retrieval to a department, a document, or a time range, which improves precision and enables multi-tenant scenarios.

Each `ai:MetadataFilter` has a key, an operator (`ai:EQUAL`, `ai:NOT_EQUAL`, `ai:GREATER_THAN`, `ai:LESS_THAN`, `ai:GREATER_THAN_OR_EQUAL`, `ai:LESS_THAN_OR_EQUAL`, `ai:IN`, `ai:NOT_IN`), and a value. Filters can be combined with `ai:AND` or `ai:OR` and nested, and the same filters work with `deleteByFilter` to remove chunks.

This example demonstrates ingesting chunks with custom metadata, retrieving with and without filters, combining filters, and deleting chunks by filter.

> Note: This example uses the default embedding provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` embedding provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_query_with_metadata_filters.bal :::

::: out rag_query_with_metadata_filters.out :::

## Related links

- [The Retrieve from an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-retrieval/)
- [The Retrieve from Pinecone example](/learn/by-example/rag-query-with-external-vector-store/)
- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
