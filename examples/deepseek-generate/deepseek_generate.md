# DeepSeek model provider — Generate API

The [`ballerinax/ai.deepseek`](https://central.ballerina.io/ballerinax/ai.deepseek/latest) module's `generate` method on `deepseek:ModelProvider` combines natural-language prompting with automatic type binding. It infers a JSON schema from the Ballerina return type, sends it alongside the prompt to the DeepSeek model, and automatically deserializes the structured response into the expected type — eliminating manual JSON parsing and making LLM output directly usable as typed Ballerina values.

DeepSeek models excel at instruction following and structured extraction tasks, offering strong performance at a competitive cost. The `DEEPSEEK_CHAT` model is well-suited for content analysis pipelines, while `DEEPSEEK_REASONER` adds chain-of-thought reasoning for more complex structured outputs.

This example demonstrates automated article metadata extraction: the model analyzes a technical article excerpt and returns a typed `ArticleMetadata` record with category, reading time, audience level, call-to-action detection, and SEO keywords.

> Note: Set the `apiKey` in the `Config.toml` file with your DeepSeek API key before running this example.

For more information on the underlying module, see the [`ballerinax/ai.deepseek` module](https://central.ballerina.io/ballerinax/ai.deepseek/latest).

::: code deepseek_generate.bal :::

::: out deepseek_generate.out :::

## Related links
- [DeepSeek Chat API example](/learn/by-example/deepseek-chat/)
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [DeepSeek API documentation](https://api-docs.deepseek.com/)
