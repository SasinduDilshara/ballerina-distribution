# Passing context to agent tools

A tool often needs values that the LLM must not choose, such as the identity of the signed-in user or the tenant of the current request. Passing them as tool parameters would put them in the schema sent to the LLM, which would then be free to supply any value for them.

The `ai:Context` carries such values from the caller to the tools. A tool receives it by declaring an `ai:Context` as its first parameter, which the compiler leaves out of the generated tool schema, so the LLM neither sees nor supplies it. The caller populates a context with `set` and passes it to `run`, and the tool reads the values with `getWithType` or `get`.

This example gives the agent a tool that lists the orders of the signed-in customer, with the customer ID supplied through the context.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_tool_context.bal :::

::: out ai_agent_tool_context.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Passing context to MCP tools example](/learn/by-example/ai-agent-mcp-context/)
- [The Agent with human-in-the-loop example](/learn/by-example/ai-agent-human-in-the-loop/)
