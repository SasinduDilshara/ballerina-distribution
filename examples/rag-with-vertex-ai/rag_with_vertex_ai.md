# RAG with Google Vertex AI

[Google Vertex AI](https://cloud.google.com/vertex-ai) provides access to Gemini and partner models as well as embedding models on Google Cloud. The [ballerinax/ai.googleapis.vertex](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest) module provides `ai:ModelProvider` and `ai:EmbeddingProvider` implementations for Vertex AI, authenticating with a service account key file, service account credentials, or OAuth2 refresh tokens.

This example demonstrates an end-to-end retrieval-augmented generation (RAG) workflow in which the embeddings are generated with a Vertex AI embedding model and the final answer with a Gemini model.

> Note: Create a Google Cloud service account with access to Vertex AI, download its JSON key file, and add the path, the project ID, and the location to the `Config.toml` file (e.g., `serviceAccountKeyPath = "/path/to/key.json"`, `projectId = "<gcp-project-id>"`, `location = "us-central1"`). Never commit credentials to source control.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code rag_with_vertex_ai.bal :::

::: out rag_with_vertex_ai.out :::

## Related links

- [The RAG with in-memory vector store example](/learn/by-example/rag-with-in-memory-vector-store/)
- [The RAG with OpenRouter example](/learn/by-example/rag-with-openrouter/)
- [The `ballerinax/ai.googleapis.vertex` module](https://central.ballerina.io/ballerinax/ai.googleapis.vertex/latest)
