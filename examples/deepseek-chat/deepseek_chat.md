# DeepSeek model provider — Chat API

The [`ballerinax/ai.deepseek`](https://central.ballerina.io/ballerinax/ai.deepseek/latest) module provides a `deepseek:ModelProvider` client that integrates DeepSeek's models into Ballerina programs. It implements the `ai:ModelProvider` interface, making it interchangeable with other provider implementations. DeepSeek models offer strong reasoning and coding capabilities at a competitive price point.

The `chat` method accepts a conversation history as an array of `ai:ChatMessage` values, enabling multi-turn conversations where the model retains context across messages. The `DEEPSEEK_CHAT` model is suited for general-purpose conversations and technical Q&A, while `DEEPSEEK_REASONER` provides deeper step-by-step reasoning for complex problems.

This example demonstrates a two-turn personal financial planning session: the user asks whether a $10,000 savings goal in 12 months is achievable on a $4,000 monthly salary, then follows up with a breakdown of their expenses. The model uses the full conversation history — including the income figure and savings target from the first turn — to give specific, contextually grounded budget advice in the second turn.

> Note: Set the `apiKey` in the `Config.toml` file with your DeepSeek API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest).

::: code deepseek_chat.bal :::

::: out deepseek_chat.out :::

## Related links
- [DeepSeek Generate API example](/learn/by-example/deepseek-generate/)
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [DeepSeek API documentation](https://api-docs.deepseek.com/)
