# RAG with HTML chunking

HTML pages are hierarchically structured documents where header tags (`<h1>`–`<h6>`) define sections and subsections. Ballerina's `ai:HtmlChunker` exploits this structure to produce semantically coherent chunks aligned with the page's layout — each chunk corresponds to a complete HTML section rather than an arbitrary slice of text.

The `HtmlChunker` uses an `HTML_HEADER` strategy by default, splitting the document at header tags first, then falling back to `<p>` paragraph tags and `<br>` line breaks. This means that when a user queries about "annual leave carry-forward", the retrieved chunk will contain the complete `<h2>Annual Leave</h2>` section, not fragments from adjacent sections.

This example demonstrates ingesting an HTML employee leave policy document using `HtmlChunker`, then answering a query about annual leave carry-forward rules from the indexed page sections.

> Note: This example uses the default embedding provider and model provider. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_html_chunking.bal :::

::: out rag_html_chunking.out :::

## Related links
- [Sample HTML policy document](https://github.com/ballerina-platform/ballerina-distribution/tree/master/examples/rag-html-chunking/leave_policy.html)
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [RAG with text chunking example](/learn/by-example/rag-text-chunking/)
- [RAG with Markdown chunking example](/learn/by-example/rag-markdown-chunking/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
