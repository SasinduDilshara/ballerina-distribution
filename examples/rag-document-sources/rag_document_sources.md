# Load documents from multiple sources

The documents for a retrieval-augmented generation (RAG) knowledge base rarely come from a single place. The `ai:DataLoader` abstraction represents any source of documents: the built-in `ai:TextDataLoader` loads local files (`pdf`, `docx`, `markdown`, `html`, and `pptx`), modules such as [ballerinax/ai.microsoft.sharepoint](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest) load from external services, and you can implement `ai:DataLoader` yourself to load from a database, an API, or a ticketing system. Content that is already in memory, such as an HTTP response body, can be wrapped as an `ai:TextDocument` directly.

Because every loader produces `ai:Document` values, documents from different sources can be combined and ingested into a knowledge base together, with metadata recording where each one came from.

This example demonstrates loading documents from files, from structured records through a custom data loader, and from in-memory content, and inspecting the combined result.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_document_sources.bal :::

::: out rag_document_sources.out :::

## Related links

- [Sample leave policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-sources/leave_policy.pdf)
- [Sample employee handbook document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-document-sources/employee_handbook.md)
- [The Load documents example](/learn/by-example/rag-document-loading/)
- [The Ingest into an in-memory vector store example](/learn/by-example/rag-in-memory-vector-store-ingestion/)
- [The `ballerinax/ai.microsoft.sharepoint` module](https://central.ballerina.io/ballerinax/ai.microsoft.sharepoint/latest)
