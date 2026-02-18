import ballerina/ai;
import ballerina/io;
import ballerinax/ai.deepseek;

// Configure the DeepSeek API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the DeepSeek model provider with the DeepSeek Chat model.
final deepseek:ModelProvider model = check new (apiKey, deepseek:DEEPSEEK_CHAT);

public function main() returns error? {
    // Define a system message for a technical Q&A assistant.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a knowledgeable technical assistant. Answer questions clearly and concisely, with examples where helpful."
    };

    // First question about a programming concept.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "What is the difference between concurrency and parallelism?"
    };

    // Build conversation history.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the DeepSeek Chat API.
    ai:ChatAssistantMessage response1 = check model->chat(messages);
    io:println("Assistant: ", response1.content);

    // Ask for a concrete example as a follow-up.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "Can you give me a real-world analogy to illustrate the difference?"
    };
    messages.push(userMessage2);

    // The model uses conversation history to provide a contextually relevant analogy.
    ai:ChatAssistantMessage response2 = check model->chat(messages);
    io:println("Assistant: ", response2.content);
}
