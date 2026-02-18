# Anthropic model provider — Generate API

The [`ballerinax/ai.anthropic`](https://central.ballerina.io/ballerinax/ai.anthropic/latest) module's `generate` method on `anthropic:ModelProvider` combines natural-language prompting with automatic type binding. It infers a JSON schema from the Ballerina return type, sends it with the prompt to the Claude model, and automatically deserializes the structured response into the expected type — eliminating manual JSON parsing.

Claude models excel at nuanced language understanding tasks such as sentiment analysis, entity extraction, and content classification, making the `generate` method particularly well-suited for structured NLP pipelines where the output must conform to a predictable schema.

This example demonstrates sentiment analysis on a customer review: the model classifies overall sentiment, confidence, dominant emotion, and key phrases, returning the results as a typed `SentimentResult` record.

> Note: Set the `apiKey` in the `Config.toml` file with your Anthropic API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.anthropic` module](https://central.ballerina.io/ballerinax/ai.anthropic/latest).

::: code anthropic_generate.bal :::

::: out anthropic_generate.out :::

## Related links
- [Anthropic Chat API example](/learn/by-example/anthropic-chat/)
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Anthropic API documentation](https://docs.anthropic.com/en/api)
