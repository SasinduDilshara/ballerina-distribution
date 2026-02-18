# Agent memory with in-memory store

AI agents often need to maintain conversation history across multiple user turns to provide coherent, context-aware responses. Ballerina's `ai:ShortTermMemory` provides session-based message storage backed by a configurable `ai:ShortTermMemoryStore`. Each conversation turn is stored under a session ID, allowing multiple independent conversations to run simultaneously without interfering with each other.

When the stored message history exceeds the store's capacity, an overflow handler decides what to do. The `ai:ModelAssistedOverflowHandlerConfiguration` instructs the memory to use an LLM to summarize the oldest messages into a concise summary, replacing them with a compact representation that preserves important context. This keeps the message window manageable while avoiding the abrupt loss of information that simpler trimming approaches cause.

This example demonstrates a task management agent with in-memory `ShortTermMemory` and model-assisted overflow handling. Three turns of a single session show the agent creating tasks and then recalling them from memory.

> Note: This example uses the default model provider. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code agent_memory_in_memory.bal :::

::: out agent_memory_in_memory.out :::

## Related links
- [Agent memory with MsSQL example](/learn/by-example/agent-memory-mssql/)
- [Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [Chat agents example](/learn/by-example/chat-agents/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
