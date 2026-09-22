import ballerina/ai;
import ballerina/io;

// Use the default model provider (with configuration added via a Ballerina VS Code command).
final ai:ModelProvider model = check ai:getDefaultModelProvider();

// Short-term memory retains a fixed number of messages per session. When the capacity is
// reached, the overflow handler decides what happens to the oldest messages.
// The default strategy trims the oldest messages. Here, the two oldest messages are trimmed
// whenever adding a message would exceed the capacity of the store (6 messages).
final ai:ShortTermMemory trimmingMemory = check new (check new ai:InMemoryShortTermMemoryStore(6),
        <ai:TrimOverflowHandlerConfiguration>{trimCount: 2});

// Alternatively, the model-assisted strategy uses an LLM to summarize the older messages
// into a single message, so the context is retained in a condensed form instead of being lost.
final ai:ShortTermMemory summarizingMemory = check new (check new ai:InMemoryShortTermMemoryStore(6),
        <ai:ModelAssistedOverflowHandlerConfiguration>{model});

final string[] userMessages = [
    "My name is Nadia and I live in Lisbon.",
    "I have a cat called Milo.",
    "I work as a marine biologist.",
    "What do you know about me? Answer in one sentence."
];

function runConversation(ai:Memory memory, string sessionId) returns error? {
    ai:Agent agent = check new ({
        systemPrompt: {
            role: "Personal Assistant",
            instructions: "You are a friendly assistant. Keep answers to one sentence."
        },
        model,
        memory
    });
    foreach string userMessage in userMessages {
        string response = check agent.run(userMessage, sessionId);
        io:println("Agent: ", response);
    }
    // Inspect the messages retained in memory after the conversation.
    ai:ChatMessage[] messages = check memory.get(sessionId);
    io:println("Messages retained: ", messages.length(), " (roles: ",
            messages.map(message => message.role.toString()), ")");
}

public function main() returns error? {
    io:println("--- Trimming on overflow ---");
    check runConversation(trimmingMemory, "session-trim");

    io:println("\n--- Summarizing on overflow ---");
    check runConversation(summarizingMemory, "session-summarize");
}
