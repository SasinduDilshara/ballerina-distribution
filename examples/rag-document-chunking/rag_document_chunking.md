# Document chunking for retrieval-augmented generation (RAG)

Documents are split into smaller chunks before they are embedded and indexed for retrieval-augmented generation (RAG). The `ai:Chunker` abstraction has implementations for Markdown (`ai:MarkdownChunker`), HTML (`ai:HtmlChunker`), and generic text (`ai:GenericRecursiveChunker`) documents. Each chunker uses the structure of the document type to produce meaningful chunks and recursively falls back to smaller units when a chunk exceeds the maximum size.

This example demonstrates how to select a chunker based on the MIME type of a document and chunk documents of different types. When documents are ingested into an `ai:VectorKnowledgeBase`, chunking is handled automatically based on the document type.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_document_chunking.bal :::

::: out rag_document_chunking.out :::

## Related links

- [The Document loading example](/learn/by-example/rag-document-loading/)
- [The RAG ingestion with external vector store example](/learn/by-example/rag-ingestion-with-external-vector-store/)
- [The Vector search with metadata filters example](/learn/by-example/rag-query-with-metadata-filters/)
