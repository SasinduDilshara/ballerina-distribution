# RAG with OpenRouter

[OpenRouter](https://openrouter.ai/) provides unified access to large language models (LLMs) and embedding models from many providers through a single API and key. The [ballerinax/ai.openrouter](https://central.ballerina.io/ballerinax/ai.openrouter/latest) module provides `ai:ModelProvider` and `ai:EmbeddingProvider` implementations for OpenRouter, so any model available on OpenRouter can be used in a retrieval-augmented generation (RAG) workflow by specifying its identifier (e.g., `openai/gpt-4o-mini`, `anthropic/claude-3.5-sonnet`).

This example demonstrates an end-to-end RAG workflow in which both the embeddings and the final answer are produced through OpenRouter.

> Note: Add the OpenRouter API key to the `Config.toml` file (e.g., `openRouterApiKey = "<your-api-key>"`). Never commit API keys to source control.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_openrouter.bal :::

::: out rag_with_openrouter.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG with Google Vertex AI example](/learn/by-example/rag-with-vertex-ai/)
- [The `ballerinax/ai.openrouter` module](https://central.ballerina.io/ballerinax/ai.openrouter/latest)
