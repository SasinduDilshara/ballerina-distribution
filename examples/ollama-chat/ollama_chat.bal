import ballerina/ai;
import ballerina/io;
import ballerinax/ai.ollama;

// Initialize the Ollama model provider.
// Ollama runs models locally — no API key required.
// The `serviceUrl` points to the local Ollama server (default: http://localhost:11434).
// Replace "llama3.2" with any model you have pulled via `ollama pull <model>`.
final ollama:ModelProvider model = check new ("llama3.2");

public function main() returns error? {
    // Define a system message for a privacy-preserving writing assistant.
    // Because Ollama runs locally, no data leaves your machine.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a helpful writing assistant. Help users improve their writing while keeping their data private on their local machine."
    };

    // First message: ask for a professional email draft.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "I need to write an email to my team about postponing our Friday meeting to next Tuesday. Make it professional but friendly."
    };

    // Build conversation history.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the local Ollama Chat API — no internet connection required.
    ai:ChatAssistantMessage response1 = check model->chat(messages);
    io:println("Assistant: ", response1.content);

    // Ask for a shorter version as a follow-up.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "Can you make it shorter? Just two sentences."
    };
    messages.push(userMessage2);

    ai:ChatAssistantMessage response2 = check model->chat(messages);
    io:println("Assistant: ", response2.content);
}
