# Anthropic model provider — Chat API

The [`ballerinax/ai.anthropic`](https://central.ballerina.io/ballerinax/ai.anthropic/latest) module provides an `anthropic:ModelProvider` client that integrates Anthropic's Claude models into Ballerina programs. It implements the `ai:ModelProvider` interface, making it interchangeable with other provider implementations such as OpenAI, Azure OpenAI, or Mistral.

Claude models are known for their strong performance on complex reasoning, careful instruction-following, and detailed natural-language understanding. The `chat` method accepts a conversation history as an array of `ai:ChatMessage` values, enabling multi-turn conversations where the model retains context across messages.

This example demonstrates a two-turn research assistant session: the assistant explains the CAP theorem and then, in the follow-up turn, names databases that prioritize consistency — using the prior context to give a more relevant answer.

> Note: Set the `apiKey` in the `Config.toml` file with your Anthropic API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest).

::: code anthropic_chat.bal :::

::: out anthropic_chat.out :::

## Related links
- [Anthropic Generate API example](/learn/by-example/anthropic-generate/)
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Anthropic API documentation](https://docs.anthropic.com/en/api)
