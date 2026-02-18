# OpenAI model provider — Embedding API

The [`ballerinax/ai.openai`](https://central.ballerina.io/ballerinax/ai.openai/latest) module provides an `openai:EmbeddingProvider` client that converts text into high-dimensional vector representations (embeddings) using OpenAI's embedding models. Embeddings capture semantic meaning, enabling tasks like semantic search, document clustering, and similarity ranking without keyword matching.

The `embed` method produces a single embedding for one chunk of text, while `batchEmbed` processes multiple chunks efficiently in a single API call. Both return `ai:Embedding` values (unit-normalized float vectors for OpenAI models), which can be compared using dot product to obtain cosine similarity scores between -1 (opposite meaning) and 1 (identical meaning).

This example demonstrates semantic similarity ranking: it compares a reference question against three candidate sentences to find which is most semantically related, using `embed` for the reference and `batchEmbed` for the candidates.

> Note: Set the `apiKey` in the `Config.toml` file with your OpenAI API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest).

::: code openai_embedding.bal :::

::: out openai_embedding.out :::

## Related links
- [RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [OpenAI Chat API example](/learn/by-example/openai-chat/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [OpenAI embeddings documentation](https://platform.openai.com/docs/guides/embeddings)
