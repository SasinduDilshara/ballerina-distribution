# MCP client — calling tools

The Model Context Protocol (MCP) `callTool` operation invokes a specific tool on an MCP server by name, passing structured arguments that match the tool's input schema. The response is a `mcp:CallToolResult` containing an array of content blocks — each block can be text, an image, audio, or an embedded resource — making the protocol flexible enough to support a wide range of tool output formats.

The `callTool` method is the primary way LLMs and AI agents interact with MCP servers: the LLM selects a tool and constructs arguments based on its schema (returned by `listTools`), and the MCP client forwards the call and returns the result. Ballerina's `mcp:StreamableHttpClient` makes this straightforward with a typed API that mirrors the MCP specification.

This example demonstrates calling two tools on a weather MCP server — `getCurrentWeather` with a city parameter and `getWeatherForecast` with a location and day count — and printing the text content from each response.

> Note: Start the weather MCP server before running this example. You can use the [MCP service example](/learn/by-example/mcp-service/) as the server. It starts on port 9090 by default.

For more information on the underlying module, see the [`ballerina/mcp` module](https://lib.ballerina.io/ballerina/mcp/latest/).

::: code mcp_client_tool_call.bal :::

::: out mcp_client_tool_call.out :::

## Related links
- [MCP client example](/learn/by-example/mcp-client/)
- [MCP service example](/learn/by-example/mcp-service/)
- [Agent with MCP integration example](/learn/by-example/ai-agent-mcp-integration/)
- [MCP specification](https://spec.modelcontextprotocol.io/)
