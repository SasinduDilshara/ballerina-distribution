# MCP client

The Model Context Protocol (MCP) is an open standard for connecting AI applications to external data sources and tools. Ballerina's [`ballerina/mcp`](https://lib.ballerina.io/ballerina/mcp/latest/) module provides both a server-side `mcp:Service` (for exposing tools) and a client-side `mcp:StreamableHttpClient` (for connecting to MCP servers and calling their tools).

The `mcp:StreamableHttpClient` connects to any MCP-compatible server via HTTP. After calling `initialize` to complete the protocol handshake, the client can call `listTools` to discover all tools exposed by the server — each tool definition includes its name, description, and JSON input schema. The client-side API mirrors what AI agents and LLM applications use to dynamically discover and invoke capabilities from MCP servers.

This example demonstrates initializing an MCP client, completing the handshake with a running MCP server, and listing all available tools with their descriptions.

> Note: Start an MCP server before running this example. You can use the [MCP service example](/learn/by-example/mcp-service/) as the server. It starts on port 9090 by default.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client.bal :::

::: out mcp_client.out :::

## Related links
- [MCP client tool call example](/learn/by-example/mcp-client-tool-call/)
- [MCP service example](/learn/by-example/mcp-service/)
- [Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
- [MCP specification](https://spec.modelcontextprotocol.io/)
