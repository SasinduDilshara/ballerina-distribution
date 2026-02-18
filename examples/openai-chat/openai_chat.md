# OpenAI model provider — Chat API

The [`ballerinax/ai.openai`](https://central.ballerina.io/ballerinax/ai.openai/latest) module provides an `openai:ModelProvider` client that integrates OpenAI's large language models into Ballerina programs. It implements the `ai:ModelProvider` interface, making it interchangeable with other provider implementations such as Anthropic, Azure OpenAI, or Mistral.

The `chat` method accepts a conversation history as an array of `ai:ChatMessage` values, enabling multi-turn conversations where the model retains context across messages. Prepending a system message lets you define the assistant's behavior, tone, and persona for the entire conversation.

This example demonstrates a two-turn customer support conversation: the assistant answers a question about file upload crashes, then provides configuration details in the follow-up turn using the full conversation history as context.

> Note: Set the `apiKey` in the `Config.toml` file with your OpenAI API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest).

::: code openai_chat.bal :::

::: out openai_chat.out :::

## Related links
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [OpenAI Generate API example](/learn/by-example/openai-generate/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [OpenAI platform documentation](https://platform.openai.com/docs/api-reference/chat)
