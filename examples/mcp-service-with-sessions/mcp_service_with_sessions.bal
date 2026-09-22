import ballerina/mcp;

// Configure the service to use stateful session management. In `mcp:STATEFUL` mode,
// the transport assigns a session ID when a client initializes the connection and
// maintains an `mcp:Session` object per client, which can be used to keep state
// across tool calls. In `mcp:STATELESS` mode, each request is independent, and
// `mcp:AUTO` (the default) decides based on whether the client initializes a session.
@mcp:StreamableHttpServiceConfig {
    info: {name: "Shopping Cart MCP Server", version: "1.0.0"},
    sessionMode: mcp:STATEFUL
}
service mcp:StreamableHttpAdvancedService /mcp on new mcp:StreamableHttpListener(9091) {

    isolated remote function onListTools() returns mcp:ListToolsResult|mcp:ServerError => {
        tools: [
            {
                name: "addItem",
                description: "Add an item to the shopping cart of the current session",
                inputSchema: {
                    "type": "object",
                    "properties": {
                        "item": {"type": "string", "description": "The name of the item"}
                    },
                    "required": ["item"]
                }
            },
            {
                name: "listItems",
                description: "List the items in the shopping cart of the current session",
                inputSchema: {"type": "object", "properties": {}}
            }
        ]
    };

    // The `session` parameter provides access to the session of the calling client.
    isolated remote function onCallTool(mcp:CallToolParams params, mcp:Session? session)
            returns mcp:CallToolResult|mcp:ServerError {
        if session is () {
            return error("A session is required to use the shopping cart");
        }

        // Read the cart stored in the session, if any.
        string[] items = [];
        if session.hasKey("items") {
            string[]|mcp:Error storedItems = session.getWithType("items");
            if storedItems is mcp:Error {
                return error("Failed to read the shopping cart", storedItems);
            }
            items = storedItems;
        }

        match params.name {
            "addItem" => {
                record {|string item;|}|error arguments = params.arguments.cloneWithType();
                if arguments is error {
                    return error("Invalid arguments", arguments);
                }
                items.push(arguments.item);
                // Store the updated cart in the session.
                session.set("items", items);
                string message = string `Added "${arguments.item}". The cart now has ${items.length()} item(s).`;
                return {content: [{'type: "text", text: message}]};
            }
            "listItems" => {
                string message = items.length() == 0 ? 
                        "The cart is empty." : "Items in the cart: " + ", ".'join(...items);
                return {content: [{'type: "text", text: message}]};
            }
        }
        return error("Unknown tool: " + params.name);
    }
}
