# Mistral model provider — Chat API

The [`ballerinax/ai.mistral`](https://central.ballerina.io/ballerinax/ai.mistral/latest) module provides a `mistral:ModelProvider` client that integrates Mistral AI's models into Ballerina programs. It implements the `ai:ModelProvider` interface, making it interchangeable with other provider implementations. Mistral models are known for strong coding and reasoning capabilities while remaining cost-efficient.

The `chat` method accepts a conversation history as an array of `ai:ChatMessage` values, enabling multi-turn conversations with full context retention. A system message can define the assistant's persona and constraints for the entire session.

This example demonstrates a two-turn code review session: the assistant identifies security vulnerabilities and bad practices in a Python function, then provides a corrected version in the follow-up turn, using the prior conversation as context.

> Note: Set the `apiKey` in the `Config.toml` file with your Mistral AI API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest).

::: code mistral_chat.bal :::

::: out mistral_chat.out :::

## Related links
- [Mistral Generate API example](/learn/by-example/mistral-generate/)
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Mistral AI documentation](https://docs.mistral.ai/)
