# Model Context Protocol (MCP) service with sessions

MCP servers that use the Streamable HTTP transport can manage sessions for their clients. The `sessionMode` field of the `@mcp:StreamableHttpServiceConfig` annotation controls the session management mode: `mcp:STATEFUL` assigns a session ID when a client initializes the connection and maintains a session per client, `mcp:STATELESS` treats each request independently, and `mcp:AUTO` (the default) decides based on whether the client initializes a session.

In stateful mode, the `onCallTool` method of an `mcp:StreamableHttpAdvancedService` receives the `mcp:Session` object of the calling client, which can be used to store and retrieve state across tool calls within the same session (e.g., a shopping cart, conversation context, or per-client preferences).

This example demonstrates an MCP server that keeps a shopping cart per client session.

> Note: Use an MCP client that initializes a session to invoke this service, for example, an AI agent with an `ai:McpToolKit` pointing to `http://localhost:9091/mcp`, or the [MCP client](/learn/by-example/mcp-client/) example adapted to this service URL and to call the `addItem` and `listItems` tools.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_service_with_sessions.bal :::

::: out mcp_service_with_sessions.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP advanced service example](/learn/by-example/mcp-service-advanced/)
- [The MCP client example](/learn/by-example/mcp-client/)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
