# Model Context Protocol (MCP) client

The Model Context Protocol (MCP) is a standard for connecting AI applications to external data sources, tools, and workflows (prompts).

In addition to creating MCP servers, Ballerina's MCP library allows you to create MCP clients that connect to MCP servers using the Streamable HTTP transport. The `mcp:StreamableHttpClient` client performs the protocol handshake, discovers the tools exposed by a server, and calls them. This is useful when integrating tools from an MCP server without an AI agent, or when building custom tooling around MCP servers. To use MCP tools from an AI agent, use `ai:McpToolKit` instead, as demonstrated in the [Agent with MCP integration](/learn/by-example/ai-agent-mcp-integration/) example.

This example demonstrates how to connect to an MCP server, list the available tools, call a tool, and close the connection.

> Note: Start the MCP server from the [MCP service](/learn/by-example/mcp-service/) example before running this example.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client.bal :::

::: out mcp_client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP advanced service example](/learn/by-example/mcp-service-advanced/)
- [The Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
