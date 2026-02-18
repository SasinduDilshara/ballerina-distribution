# Azure OpenAI model provider — Generate API

The [`ballerinax/ai.azure`](https://central.ballerina.io/ballerinax/ai.azure/latest) module's `generate` method on `azure:OpenAiModelProvider` combines natural-language prompting with automatic type binding. It infers a JSON schema from the Ballerina return type, sends it with the prompt to the Azure-hosted model, and deserializes the structured response directly into the expected type — eliminating manual JSON parsing.

Azure OpenAI is often preferred over the public OpenAI API in enterprise environments because it provides data residency, compliance certifications (SOC 2, ISO 27001, HIPAA), private networking via Azure Virtual Networks, and SLA-backed uptime. The `generate` method is well-suited for content analysis, extraction, classification, and any task requiring predictable, schema-bound output.

This example demonstrates structured content review: it sends a technical article snippet to the model and retrieves a `ContentReview` record containing a quality score, sentiment, key topics, an inappropriate-content flag, and an optional improvement suggestion.

> Note: Set `serviceUrl`, `apiKey`, `deploymentId`, and `apiVersion` in the `Config.toml` file with your Azure OpenAI resource details before running this example.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code azure_openai_generate.bal :::

::: out azure_openai_generate.out :::

## Related links
- [Azure OpenAI Chat API example](/learn/by-example/azure-openai-chat/)
- [Direct LLM calls example](/learn/by-example/direct-llm-calls/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Azure OpenAI Service documentation](https://learn.microsoft.com/azure/ai-services/openai/)
