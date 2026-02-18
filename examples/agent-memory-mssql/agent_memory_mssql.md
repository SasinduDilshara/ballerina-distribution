# Agent memory with MsSQL

In-memory conversation storage is lost when the application restarts, which is impractical for production AI agents that must serve many sessions over time. The [`ballerinax/ai.memory.mssql`](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest) module provides an `mssql:ShortTermMemoryStore` that persists conversation history in a Microsoft SQL Server database table, making agent memory durable, horizontally scalable, and shareable across multiple application instances.

The `mssql:ShortTermMemoryStore` implements the `ai:ShortTermMemoryStore` interface and can be passed directly to `ai:ShortTermMemory`. It accepts standard SQL Server connection parameters and automatically creates the storage table if it does not exist. Each session's message history is stored and retrieved by session ID, so multiple concurrent users each have isolated, persistent conversation threads.

This example demonstrates a customer support agent with MsSQL-backed persistent memory. Three conversation turns show the agent recalling the customer's name, operating system, and prior troubleshooting steps from the database.

> Note: This example uses the default model provider. Set `dbHost`, `dbUser`, `dbPassword`, and `dbName` in the `Config.toml` file with your SQL Server connection details. To configure the WSO2 default provider, open the VS Code command palette and run the `Configure default WSO2 Model Provider` command.

For more information on the underlying module, see the [`ballerinax/ai.memory.mssql` module](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest).

::: code agent_memory_mssql.bal :::

::: out agent_memory_mssql.out :::

## Related links
- [Agent memory with in-memory store example](/learn/by-example/agent-memory-in-memory/)
- [Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [Chat agents example](/learn/by-example/chat-agents/)
- [The `ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/)
