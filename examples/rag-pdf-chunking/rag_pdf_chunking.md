# RAG with PDF chunking

PDF documents are the most common format for corporate policies, manuals, and reports. Ballerina's `ai:TextDataLoader` extracts the text content from a PDF and returns it as an `ai:Document`, ready for chunking and embedding. Because PDFs are stored as plain text after extraction, `ai:GenericRecursiveChunker` is the appropriate chunker: it splits the extracted text at paragraph boundaries, falling back to sentence, word, and character boundaries, with a configurable overlap to preserve context across chunk boundaries.

This example demonstrates ingesting a PDF employee leave policy document using `GenericRecursiveChunker` with custom `maxChunkSize` and `maxOverlapSize` settings, then answering a query about the leave request procedure from the indexed content.

> Note: This example uses the default embedding provider and model provider. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_pdf_chunking.bal :::

::: out rag_pdf_chunking.out :::

## Related links
- [Sample PDF policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-pdf-chunking/leave_policy.pdf)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with text chunking example](/learn/by-example/rag-text-chunking/)
- [RAG with Markdown chunking example](/learn/by-example/rag-markdown-chunking/)
- [RAG with HTML chunking example](/learn/by-example/rag-html-chunking/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
