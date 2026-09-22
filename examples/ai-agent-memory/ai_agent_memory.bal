import ballerina/ai;
import ballerina/io;

// Agents use memory to keep the conversation history of each session, so that follow-up
// questions can refer to earlier messages. By default, an agent uses in-memory short-term
// memory with a fixed capacity. Configure the memory explicitly to control the capacity
// (the number of recent user, assistant, and tool messages retained per session; the system
// message is kept separately), the store, or the overflow handling.
final ai:Memory memory = check new ai:ShortTermMemory(check new ai:InMemoryShortTermMemoryStore(20));

final ai:Agent travelAgent = check new ({
    systemPrompt: {
        role: "Travel Assistant",
        instructions: string `You help users plan trips. Remember the details the user
            shares and use them in later answers. Keep answers to two sentences.`
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    memory
});

public function main() returns error? {
    // Messages exchanged in a session are stored in memory against the session ID,
    // so the agent can use the earlier context to answer follow-up questions.
    string sessionId = "user-1";
    string response = check travelAgent.run(
            "I'm planning a 5-day trip to Japan in April with my two kids.", sessionId);
    io:println(response);
    response = check travelAgent.run(
            "Suggest one activity for the trip that suits the people travelling.", sessionId);
    io:println(response);

    // Each session has its own memory. A different session does not have access
    // to the conversation above.
    response = check travelAgent.run("Where am I planning to travel?", "user-2");
    io:println(response);

    // The stored messages can be retrieved or deleted using the memory instance.
    ai:ChatMessage[] messages = check memory.get(sessionId);
    io:println("\nMessages stored for session 'user-1': ", messages.length());
    check memory.delete(sessionId);
}
