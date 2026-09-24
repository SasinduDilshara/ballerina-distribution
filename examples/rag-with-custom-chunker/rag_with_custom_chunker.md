# Implement a custom chunker

The built-in chunkers (`ai:GenericRecursiveChunker`, `ai:MarkdownChunker`, and `ai:HtmlChunker`) split documents by structure and size. When your documents have a domain-specific structure, such as FAQ entries, log records, or transcripts, a chunker that understands that structure produces better chunks for retrieval. Implement the `ai:Chunker` type, whose single `chunk` method takes an `ai:Document` and returns the `ai:Chunk` values, to create such a chunker.

A custom chunker is used exactly like a built-in one: call its `chunk` method directly, or pass it to an `ai:VectorKnowledgeBase` so that documents are chunked with it during ingestion, as shown in the [Ingest with a configured chunker](/learn/by-example/rag-with-configured-chunker/) example.

This example demonstrates a chunker that splits an FAQ document into one chunk per question-and-answer pair and records the question as chunk metadata.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_custom_chunker.bal :::

::: out rag_with_custom_chunker.out :::

## Related links

- [The Chunk documents example](/learn/by-example/rag-document-chunking/)
- [The Ingest with a configured chunker example](/learn/by-example/rag-with-configured-chunker/)
- [The Ingest without chunking example](/learn/by-example/rag-without-chunking/)
