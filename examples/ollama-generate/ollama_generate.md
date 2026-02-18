# Ollama model provider — Generate API

The [`ballerinax/ai.ollama`](https://central.ballerina.io/ballerinax/ai.ollama/latest) module's `generate` method on `ollama:ModelProvider` combines natural-language prompting with automatic type binding, running entirely on the local machine via [Ollama](https://ollama.com/). It infers a JSON schema from the Ballerina return type, sends it alongside the prompt to the local model, and deserializes the structured response into the expected type — all without sending any data to external services.

The `generate` method is particularly valuable in privacy-sensitive use cases such as classifying documents that contain confidential or legally sensitive content, where cloud APIs cannot be used. Because Ollama runs models locally, both the input data and the model responses remain on-premise.

This example demonstrates local document classification: it classifies a legal contract excerpt into a category, subcategory, confidence level, key terms, and a sensitive-information flag — entirely on-device.

> Note: Install [Ollama](https://ollama.com/) and pull a model (e.g., `ollama pull llama3.2`) before running this example. The Ollama server must be running at `http://localhost:11434`.

For more information on the underlying module, see the [`ballerinax/ai.ollama` module](https://central.ballerina.io/ballerinax/ai.ollama/latest).

::: code ollama_generate.bal :::

::: out ollama_generate.out :::

## Related links
- [Ollama Chat API example](/learn/by-example/ollama-chat/)
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Ollama model library](https://ollama.com/library)
