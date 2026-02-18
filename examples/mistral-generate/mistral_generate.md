# Mistral model provider — Generate API

The [`ballerinax/ai.mistral`](https://central.ballerina.io/ballerinax/ai.mistral/latest) module's `generate` method on `mistral:ModelProvider` combines natural-language prompting with automatic type binding. It infers a JSON schema from the Ballerina return type, sends it alongside the prompt to the Mistral model, and automatically deserializes the structured response into the expected type.

Mistral models offer strong performance on code analysis and technical reasoning tasks at a competitive cost, making them a practical choice for developer tooling pipelines. The `generate` method is ideal for structured extraction where the LLM output must conform to a schema — whether for scoring, classification, or information extraction.

This example demonstrates automated code quality analysis: the model evaluates a JavaScript snippet and returns a `CodeQualityReport` record containing a score, identified issues, complexity rating, naming convention compliance, and a top recommendation.

> Note: Set the `apiKey` in the `Config.toml` file with your Mistral AI API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.mistral` module](https://central.ballerina.io/ballerinax/ai.mistral/latest).

::: code mistral_generate.bal :::

::: out mistral_generate.out :::

## Related links
- [Mistral Chat API example](/learn/by-example/mistral-chat/)
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Mistral AI documentation](https://docs.mistral.ai/)
