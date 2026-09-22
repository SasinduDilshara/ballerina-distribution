# Agent tool loading strategy

An agent sends the definitions of the tools it can use to the LLM so that the LLM can decide which tools to call. By default (`ai:NO_FILTER`), the full schemas of all tools are included in every request. As the number of tools grows, this increases the prompt size and cost.

The `ai:LLM_FILTER` tool loading strategy uses a selective, two-step approach: only the tool names and descriptions are sent first, the LLM selects the tools relevant to the user's query, and only the full schemas of the selected tools are then loaded to obtain the parameters for execution. The strategy is configured via the `toolLoadingStrategy` field of the agent configuration.

This example demonstrates an HR assistant agent with several tools that uses the `ai:LLM_FILTER` strategy.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_loading_strategy.bal :::

::: out ai_agent_tool_loading_strategy.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with tool kits example](/learn/by-example/ai-agent-tool-kit/)
