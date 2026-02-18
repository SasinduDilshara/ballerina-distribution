import ballerina/ai;
import ballerina/io;
import ballerina/time;
import ballerina/uuid;

type Task record {|
    string description;
    time:Date dueBy?;
    boolean completed = false;
|};

// Simple in-memory task store.
isolated map<Task> tasks = {};

@ai:AgentTool
isolated function addTask(string description, time:Date? dueBy) returns error? {
    lock {
        tasks[uuid:createRandomUuid()] = {description, dueBy: dueBy.clone()};
    }
}

@ai:AgentTool
isolated function listTasks() returns Task[] {
    lock {
        return tasks.toArray().clone();
    }
}

// Create an in-memory ShortTermMemory store.
// When the message window fills up, the ModelAssistedOverflowHandlerConfiguration
// uses an LLM to summarize the oldest messages into a compact summary,
// preserving context without growing the history unboundedly.
final ai:ModelProvider modelProvider = check ai:getDefaultModelProvider();

final ai:ShortTermMemory memory = check new (
    overflowConfiguration = <ai:ModelAssistedOverflowHandlerConfiguration>{
        model: modelProvider
    }
);

// Build an agent that uses the shared memory for all sessions.
final ai:Agent taskAgent = check new ({
    systemPrompt: {
        role: "Task Assistant",
        instructions: "You are a helpful task management assistant. Help users manage their to-do list."
    },
    tools: [addTask, listTasks],
    model: modelProvider,
    memory: memory
});

public function main() returns error? {
    // Simulate a multi-turn conversation in a named session.
    // The `sessionId` links turns of the same conversation together in memory.
    string sessionId = "user-alice";

    string response1 = check taskAgent.run("I need to buy groceries by tomorrow.", sessionId);
    io:println("Agent: ", response1);

    // In a second turn, the agent recalls from memory what was discussed.
    string response2 = check taskAgent.run("Also add 'Pay electricity bill' for next Friday.", sessionId);
    io:println("Agent: ", response2);

    // The agent can look up prior context without re-stating it.
    string response3 = check taskAgent.run("What tasks do I have?", sessionId);
    io:println("Agent: ", response3);
}
