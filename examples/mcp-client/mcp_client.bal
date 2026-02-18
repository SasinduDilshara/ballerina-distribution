import ballerina/io;
import ballerina/mcp;

public function main() returns error? {
    // Initialize the MCP client, pointing it at a running MCP server.
    // The server must be accessible at the given URL (e.g., the mcp-service BBE).
    mcp:StreamableHttpClient mcpClient = check new ("http://localhost:9090/mcp");

    // Send the MCP `initialize` handshake to the server.
    // This establishes the session and negotiates protocol capabilities.
    _ = check mcpClient->initialize(
        clientInfo = {name: "MCP Demo Client", 'version: "1.0.0"}
    );
    io:println("MCP client initialized successfully");

    // List all tools available on the connected MCP server.
    // Each tool includes its name, description, and input schema.
    mcp:ListToolsResult toolsResult = check mcpClient->listTools();
    io:println("Available tools (", toolsResult.tools.length(), "):");
    foreach mcp:ToolDefinition tool in toolsResult.tools {
        io:println("  - ", tool.name, ": ", tool.description ?: "(no description)");
    }

    // Close the MCP client session when done.
    check mcpClient->close();
}
