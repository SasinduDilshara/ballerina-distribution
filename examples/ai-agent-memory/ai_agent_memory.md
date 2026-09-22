# Agent with memory

AI agents use memory to keep the conversation history of each session, so that the LLM can use the earlier context when answering follow-up questions. Memory is keyed by a session ID, which allows a single agent to serve many users or conversations concurrently while keeping their histories separate.

By default, an agent is configured with in-memory short-term memory (`ai:ShortTermMemory` with an `ai:InMemoryShortTermMemoryStore`) that retains a fixed number of recent messages per session. You can configure the memory explicitly to change the capacity, use a persistent store (e.g., PostgreSQL, Redis, or SQLite via the `ballerinax/ai.memory.*` and `ballerinax/ai.sqlite` modules), or customize how overflow is handled. To create a stateless agent, set the `memory` field to `()`.

This example demonstrates how conversation history is retained per session and how to inspect and clear the stored messages.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_memory.bal :::

::: out ai_agent_memory.out :::

## Related links
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
- [The Memory overflow handling example](/learn/by-example/ai-agent-memory-overflow-handling/)
- [The Chat agents example](/learn/by-example/chat-agents/)
- [The `ballerinax/ai.memory.postgresql` module](https://central.ballerina.io/ballerinax/ai.memory.postgresql/latest)
- [The `ballerinax/ai.memory.redis` module](https://central.ballerina.io/ballerinax/ai.memory.redis/latest)
- [The `ballerinax/ai.memory.mssql` module](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest)
- [The `ballerinax/ai.sqlite` module](https://central.ballerina.io/ballerinax/ai.sqlite/latest)
