# Agent with persistent memory

By default, an agent keeps the conversation history in memory, which is lost when the program stops and cannot be shared across multiple instances of the agent. To persist the conversation history, use a persistent short-term memory store (`ai:ShortTermMemoryStore` implementation) with the `ai:ShortTermMemory`.

Ballerina provides persistent stores backed by SQLite ([ballerinax/ai.sqlite](https://central.ballerina.io/ballerinax/ai.sqlite/latest)), PostgreSQL ([ballerinax/ai.memory.postgresql](https://central.ballerina.io/ballerinax/ai.memory.postgresql/latest)), Redis ([ballerinax/ai.memory.redis](https://central.ballerina.io/ballerinax/ai.memory.redis/latest)), and Microsoft SQL Server ([ballerinax/ai.memory.mssql](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest)). The same stores also persist the checkpoints of runs paused for human approval, provided the checkpoint table is created beforehand (see the module documentation for the schema).

This example demonstrates an agent whose conversation history is persisted in a SQLite database. Run the program twice to observe that the second run continues the conversation stored by the first run.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_persistent_memory.bal :::

::: out ai_agent_persistent_memory.out :::

## Related links
- [The Agent with memory example](/learn/by-example/ai-agent-memory/)
- [The Memory overflow handling example](/learn/by-example/ai-agent-memory-overflow-handling/)
- [The `ballerinax/ai.sqlite` module](https://central.ballerina.io/ballerinax/ai.sqlite/latest)
- [The `ballerinax/ai.memory.postgresql` module](https://central.ballerina.io/ballerinax/ai.memory.postgresql/latest)
- [The `ballerinax/ai.memory.redis` module](https://central.ballerina.io/ballerinax/ai.memory.redis/latest)
- [The `ballerinax/ai.memory.mssql` module](https://central.ballerina.io/ballerinax/ai.memory.mssql/latest)
