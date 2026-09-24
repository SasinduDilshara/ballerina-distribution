import ballerina/log;
import ballerina/mcp;

type Ticket record {|
    string id;
    string tenantId;
    string subject;
|};

final readonly & Ticket[] tickets = [
    {id: "TCK-1", tenantId: "acme", subject: "Payment gateway timeout"},
    {id: "TCK-2", tenantId: "globex", subject: "Login fails on mobile"},
    {id: "TCK-3", tenantId: "acme", subject: "Report export is empty"}
];

listener mcp:StreamableHttpListener mcpListener = new (9090);

// An advanced service receives the whole `mcp:CallToolParams`, which includes the `_meta`
// field of the request. Metadata is information about the call rather than an argument of the
// tool, so it is where a client puts values the LLM must not choose, such as the tenant of the
// caller. The tool schema does not mention them, so the LLM never sees them.
service mcp:StreamableHttpAdvancedService /mcp on mcpListener {

    isolated remote function onListTools() returns mcp:ListToolsResult|mcp:ServerError => {
        tools: [
            {
                name: "getOpenTickets",
                description: "Get the open support tickets of the calling tenant",
                inputSchema: {"type": "object", "properties": {}}
            }
        ]
    };

    isolated remote function onCallTool(mcp:CallToolParams params)
            returns mcp:CallToolResult|mcp:ServerError {
        if params.name != "getOpenTickets" {
            return error("Unknown tool: " + params.name);
        }

        // `mcp:Meta` is an open record, so a client can attach its own fields to `_meta`.
        anydata tenantId = params._meta["tenantId"];
        if tenantId !is string {
            return error("The 'tenantId' metadata is missing from the request");
        }

        log:printInfo("Listing tickets", tenantId = tenantId);
        Ticket[] tenantTickets = from Ticket ticket in tickets
            where ticket.tenantId == tenantId
            select ticket;
        return {content: [{'type: "text", text: tenantTickets.toJsonString()}]};
    }
}
