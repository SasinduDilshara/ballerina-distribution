# RAG with Markdown chunking

Markdown documents are structured documents where headers (`#`, `##`, `###`) naturally delineate semantic sections. Ballerina's `ai:MarkdownChunker` exploits this structure to produce higher-quality chunks than generic text splitting: each chunk corresponds to a coherent section of the document (such as a policy article or a README section), preserving meaning that would be lost by arbitrary character-count splitting.

The `MarkdownChunker` uses a `MARKDOWN_HEADER` strategy by default, splitting the document at `##` header boundaries first, then `###`, and falling back to code blocks, horizontal rules, and paragraphs when needed. Because each chunk aligns with a document section, semantic retrieval is more precise — a query about "leave request procedure" directly retrieves the section titled "Leave Request Procedure" rather than fragments of surrounding sections.

This example demonstrates ingesting a Markdown leave policy document using `MarkdownChunker`, then answering a query about the leave request process from the indexed sections.

> Note: This example uses the default embedding provider and model provider. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_markdown_chunking.bal :::

::: out rag_markdown_chunking.out :::

## Related links
- [Sample policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-markdown-chunking/leave_policy.md)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with text chunking example](/learn/by-example/rag-text-chunking/)
- [RAG with HTML chunking example](/learn/by-example/rag-html-chunking/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
