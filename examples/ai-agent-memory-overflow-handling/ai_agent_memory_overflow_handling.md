# Memory overflow handling

Short-term memory retains a fixed number of recent messages per session. When a session reaches the capacity of the memory store, the overflow handler configured for the `ai:ShortTermMemory` decides what happens to the oldest messages. The trim strategy (`ai:TrimOverflowHandlerConfiguration`, the default) removes the oldest messages, and the model-assisted strategy (`ai:ModelAssistedOverflowHandlerConfiguration`) uses an LLM to summarize the older messages into a single message, so that important context is retained in a condensed form.

This example demonstrates the model-assisted strategy with a small memory capacity, so that overflow occurs within a short conversation. The messages held in memory are printed before and after the overflow, to show the older messages being replaced by a summary.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_memory_overflow_handling.bal :::

::: out ai_agent_memory_overflow_handling.out :::

## Related links
- [The Agent with in-memory short-term memory example](/learn/by-example/ai-agent-memory/)
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
