import ballerina/ai;
import ballerina/io;
import ballerinax/ai.memory.mssql;

// Configure MsSQL connection details via Config.toml.
configurable string dbHost = ?;
configurable string dbUser = ?;
configurable string dbPassword = ?;
configurable string dbName = ?;

// Create an MsSQL-backed ShortTermMemoryStore.
// This stores conversation history in a SQL Server database table,
// making it persistent across application restarts and horizontally scalable.
// The table is created automatically if it does not exist.
final mssql:ShortTermMemoryStore memoryStore = check new ({
    host: dbHost,
    user: dbUser,
    password: dbPassword,
    database: dbName
});

// Create ShortTermMemory using the MsSQL-backed store.
final ai:ShortTermMemory memory = check new (memoryStore);

// Use the default model provider (configured via VS Code command).
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

// Build a customer support agent that uses persistent memory.
// Each customer session is identified by a unique session ID,
// and the conversation history is retrieved from the database on each turn.
final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: "You are a friendly customer support agent for a software company. Help customers resolve issues concisely and professionally. Remember details shared earlier in the conversation."
    },
    tools: [],
    model: modelProvider,
    memory: memory
});

public function main() returns error? {
    // Simulate a returning customer conversation using a persistent session ID.
    // In a real application, this ID would come from the user's authentication context.
    string sessionId = "customer-12345";

    // First turn: customer describes their issue.
    string response1 = check supportAgent.run(
        "Hi, my name is Sarah and I'm having trouble installing your desktop app on Windows 11.",
        sessionId
    );
    io:println("Agent: ", response1);

    // Second turn: the agent recalls Sarah's name and OS from memory.
    string response2 = check supportAgent.run(
        "I already tried reinstalling it twice but it still crashes on startup.",
        sessionId
    );
    io:println("Agent: ", response2);

    // Third turn: agent provides a follow-up step, remembering the full context.
    string response3 = check supportAgent.run("Where do I find the crash logs?", sessionId);
    io:println("Agent: ", response3);
}
