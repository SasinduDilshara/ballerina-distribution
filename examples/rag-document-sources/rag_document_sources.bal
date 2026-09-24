import ballerina/ai;
import ballerina/io;

# Represents a resolved support ticket stored in a ticketing system.
type Ticket record {|
    string id;
    string subject;
    string resolution;
|};

// A custom data loader that implements the `ai:DataLoader` type. Any source can be exposed
// as a data loader: a database, an API, a ticketing system, etc. Here, the loader turns
// ticket records into text documents, keeping the ticket details as metadata.
isolated class TicketDataLoader {
    *ai:DataLoader;

    private final readonly & Ticket[] tickets;

    isolated function init(Ticket[] tickets) {
        self.tickets = tickets.cloneReadOnly();
    }

    public isolated function load() returns ai:Document[]|ai:Document|ai:Error {
        ai:Document[] documents = [];
        foreach Ticket ticket in self.tickets {
            ai:TextDocument document = {
                content: string `${ticket.subject}: ${ticket.resolution}`,
                metadata: {"origin": "ticketing-system", "ticketId": ticket.id}
            };
            documents.push(document);
        }
        return documents;
    }
}

public function main() returns error? {
    // Source 1: files. The built-in `ai:TextDataLoader` loads `pdf`, `docx`, `markdown`,
    // `html`, and `pptx` files as text documents.
    ai:DataLoader fileLoader = check new ai:TextDataLoader("./leave_policy.pdf", "./employee_handbook.md");
    ai:Document[] documents = toArray(check fileLoader.load());

    // Source 2: structured records from another system, via a custom data loader.
    ai:DataLoader ticketLoader = new TicketDataLoader([
        {id: "T-1042", subject: "VPN disconnects", resolution: "Update the VPN client to version 5.2 or later."},
        {id: "T-1043", subject: "Expense portal login", resolution: "Reset the SSO password and clear the browser cache."}
    ]);
    documents.push(...toArray(check ticketLoader.load()));

    // Source 3: content already in memory, such as the body of an HTTP response or a message,
    // can be wrapped as a document directly.
    documents.push(<ai:TextDocument>{
        content: "The office is closed on public holidays. Remote work is allowed on those days for critical support staff.",
        metadata: {"origin": "announcements", "fileName": "holiday-notice"}
    });

    // All the documents share the `ai:Document` type, so they can be ingested into a
    // knowledge base together, regardless of where they came from.
    io:println("Documents loaded: ", documents.length());
    foreach ai:Document document in documents {
        json metadataJson = document.metadata.toJson();
        map<json> metadata = metadataJson is map<json> ? metadataJson : {};
        json origin = metadata["origin"];
        string label = origin is string ? origin : "file";
        io:println("- [", label, "] ", metadata["fileName"] ?: metadata["ticketId"],
                " (", document.content.toString().length(), " characters)");
    }
}

function toArray(ai:Document|ai:Document[] loaded) returns ai:Document[] {
    if loaded is ai:Document[] {
        return loaded;
    }
    return [loaded];
}
