# OpenAI model provider — Generate API

The [`ballerinax/ai.openai`](https://central.ballerina.io/ballerinax/ai.openai/latest) module provides the `generate` method on `openai:ModelProvider`, which combines natural-language prompting with automatic type binding. Unlike the `chat` method, which manages multi-turn conversations, `generate` is designed for single-shot interactions where the LLM response must conform to a specific Ballerina type.

The `generate` method infers a JSON schema from the return type descriptor, sends it alongside the prompt to the LLM, and automatically deserializes the structured JSON response into the expected type. This works with any Ballerina type — records, primitive types, arrays, or any combination — eliminating the need for manual JSON parsing.

This example demonstrates extracting structured blog metadata (title, tags, and a summary) from a content string, returning the result as a typed `BlogMetadata` record.

> Note: Set the `apiKey` in the `Config.toml` file with your OpenAI API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.openai` module](https://central.ballerina.io/ballerinax/ai.openai/latest).

::: code openai_generate.bal :::

::: out openai_generate.out :::

## Related links
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [OpenAI Chat API example](/learn/by-example/openai-chat/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [OpenAI platform documentation](https://platform.openai.com/docs/api-reference)
