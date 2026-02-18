import ballerina/ai;
import ballerina/io;
import ballerinax/ai.openai;

// Configure the OpenAI API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the OpenAI model provider with the GPT-4o model.
final openai:ModelProvider model = check new (apiKey, openai:GPT_4O);

public function main() returns error? {
    // Define a system message that sets the assistant's behavior and persona.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a helpful customer support assistant for a software company. Be concise and professional."
    };

    // First user message asking about a product issue.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "My application crashes when I try to upload files larger than 10MB. How can I fix this?"
    };

    // Build the conversation history starting with the system context and first message.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the OpenAI Chat API with the conversation history.
    ai:ChatAssistantMessage response1 = check model->chat(messages);
    io:println("Assistant: ", response1.content);

    // Append the assistant's response to the history to preserve context.
    messages.push(response1);

    // Send a follow-up question — the model uses the full history for context.
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "What configuration changes do I need to make?"
    };
    messages.push(userMessage2);

    // The model uses the full conversation history to give a contextually relevant response.
    ai:ChatAssistantMessage response2 = check model->chat(messages);
    io:println("Assistant: ", response2.content);
}
