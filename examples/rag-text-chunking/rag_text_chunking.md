# RAG with text chunking

In retrieval-augmented generation (RAG) workflows, long documents must be split into smaller chunks before embedding and indexing into a vector store. The choice of chunking strategy directly affects retrieval quality: chunks that are too large dilute semantic precision, while chunks that are too small lose context.

Ballerina's `ai:GenericRecursiveChunker` splits plain text documents using a configurable hierarchy of separators — paragraph boundaries first, then sentence, word, and character boundaries — with an optional overlap between adjacent chunks to preserve context across chunk boundaries. The chunker is passed directly to `ai:VectorKnowledgeBase`, replacing the default `AUTO` chunker for explicit control over chunk size and overlap.

This example demonstrates ingesting a plain-text employee leave policy using `GenericRecursiveChunker` with custom `maxChunkSize` and `maxOverlapSize` settings, then answering a query about sick leave entitlement from the indexed content.

> Note: This example uses the default embedding provider and model provider. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_text_chunking.bal :::

::: out rag_text_chunking.out :::

## Related links
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with Markdown chunking example](/learn/by-example/rag-markdown-chunking/)
- [RAG with HTML chunking example](/learn/by-example/rag-html-chunking/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
