import ballerina/io;
import ballerina/mcp;

public function main() returns error? {
    // Initialize the MCP client connected to the weather MCP server.
    mcp:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");

    // Complete the MCP handshake to establish the session.
    _ = check mcpClient->initialize(
        clientInfo = {name: "MCP Weather Client", 'version: "1.0.0"}
    );

    // Call the `getCurrentWeather` tool with a city parameter.
    // The `arguments` field is a map of parameter names to their values,
    // matching the tool's input schema.
    mcp:CallToolResult weatherResult = check mcpClient->callTool({
        name: "getCurrentWeather",
        arguments: {"city": "Tokyo"}
    });

    // Extract text content from the tool result.
    // MCP tool results contain an array of content blocks (text, image, audio, etc.).
    io:println("Current weather in Tokyo:");
    foreach var content in weatherResult.content {
        if content is mcp:TextContent {
            io:println("  ", content.text);
        }
    }

    // Call the `getWeatherForecast` tool with location and number of days.
    mcp:CallToolResult forecastResult = check mcpClient->callTool({
        name: "getWeatherForecast",
        arguments: {"location": "Tokyo", "days": 3}
    });

    io:println("\n3-day forecast for Tokyo:");
    foreach var content in forecastResult.content {
        if content is mcp:TextContent {
            io:println("  ", content.text);
        }
    }

    // Close the MCP session when done.
    check mcpClient->close();
}
