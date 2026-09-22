import ballerina/ai;
import ballerina/io;
import ballerinax/ai.sqlite;

// Use a persistent short-term memory store, so that the conversation history survives
// restarts and can be shared by multiple instances of the agent. This example uses SQLite
// via the `ballerinax/ai.sqlite` module, which runs in-process and needs no external service.
// PostgreSQL, Redis, and MSSQL stores are available via the `ballerinax/ai.memory.*` modules.
final sqlite:ShortTermMemoryStore store = check new ({url: "jdbc:sqlite:./agent_memory.db"},
        // The maximum number of messages retained per session.
        maxMessagesPerKey = 30);

final ai:Memory memory = check new ai:ShortTermMemory(store);

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Assistant",
        instructions: string `You help customers with their orders. Remember the details
            the customer shares and use them in later answers. Keep answers brief.`
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    memory
});

public function main() returns error? {
    string sessionId = "customer-42";

    // Check whether the session already has history (e.g., from a previous run of the program).
    ai:ChatMessage[] history = check memory.get(sessionId);
    if history.length() == 0 {
        io:println("No previous conversation found. Starting a new conversation.");
        string response = check supportAgent.run(
                "Hi, my order number is ORD-7781 and it hasn't arrived yet.", sessionId);
        io:println(response);
    } else {
        io:println("Continuing the conversation from ", history.length(), " stored messages.");
    }

    // Since the history is persisted in the database, the agent can answer this even if the
    // program was restarted after the first message. Run the program again to observe this.
    string response = check supportAgent.run("What was my order number again?", sessionId);
    io:println(response);
}
