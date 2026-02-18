# Ollama model provider — Chat API

The [`ballerinax/ai.ollama`](https://central.ballerina.io/ballerinax/ai.ollama/latest) module provides an `ollama:ModelProvider` client that integrates locally-running LLMs via [Ollama](https://ollama.com/) into Ballerina programs. Unlike cloud-based providers, Ollama runs models entirely on your machine — no API key is required, and no data is sent to external services. This makes it ideal for privacy-sensitive workflows, offline environments, and development without cloud costs.

The `chat` method works identically to cloud provider implementations: it accepts an array of `ai:ChatMessage` values and returns an `ai:ChatAssistantMessage`, enabling multi-turn conversations with full context retention. The model is specified by name (e.g., `"llama3.2"`) and must be available locally via `ollama pull <model-name>`.

This example demonstrates a local writing assistant that helps draft and shorten a professional email — with all processing happening on the local machine.

> Note: Install [Ollama](https://ollama.com/) and pull a model (e.g., `ollama pull llama3.2`) before running this example. The Ollama server must be running at `http://localhost:11434`.

For more information on the underlying module, see the [`ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest).

::: code ollama_chat.bal :::

::: out ollama_chat.out :::

## Related links
- [Ollama Generate API example](/learn/by-example/ollama-generate/)
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Ollama documentation](https://ollama.com/library)
