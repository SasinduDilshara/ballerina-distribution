# Azure OpenAI model provider — Chat API

The [`ballerinax/ai.azure`](https://central.ballerina.io/ballerinax/ai.azure/latest) module provides the `azure:OpenAiModelProvider` client, which integrates Azure-hosted OpenAI models into Ballerina programs. Unlike the `ballerinax/ai.openai` module that connects directly to OpenAI's API, `ai.azure` routes requests through your Azure OpenAI resource, enabling enterprise features such as private networking, data residency, and compliance controls.

The `azure:OpenAiModelProvider` is initialized with an Azure service URL, API key, deployment ID, and API version — all available from your Azure portal. The `chat` method works identically to other `ai:ModelProvider` implementations: it accepts an array of `ai:ChatMessage` values and returns an `ai:ChatAssistantMessage`, preserving conversation context across turns.

This example demonstrates a two-turn HR assistant conversation, where an employee asks about annual leave entitlements and then follows up on carry-forward rules, with the model maintaining context between turns.

> Note: Set `serviceUrl`, `apiKey`, `deploymentId`, and `apiVersion` in the `Config.toml` file with your Azure OpenAI resource details before running this example.

For more information on the underlying module, see the [`ballerinax/ai.azure` module](https://central.ballerina.io/ballerinax/ai.azure/latest).

::: code azure_openai_chat.bal :::

::: out azure_openai_chat.out :::

## Related links
- [Azure OpenAI Generate API example](/learn/by-example/azure-openai-generate/)
- [Direct LLM calls with history example](/learn/by-example/direct-llm-calls-with-history/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
- [Azure OpenAI Service documentation](https://learn.microsoft.com/azure/ai-services/openai/)
