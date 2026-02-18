import ballerina/ai;
import ballerina/io;
import ballerinax/ai.anthropic;

// Configure the Anthropic API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the Anthropic model provider with the Claude Sonnet model.
final anthropic:ModelProvider model = check new (apiKey, anthropic:CLAUDE_SONNET_4_20250514);

public function main() returns error? {
    // Start a research Q&A session with a system message that defines the assistant's role.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a knowledgeable research assistant. Provide accurate, well-structured answers. Keep responses concise and cite key concepts where relevant."
    };

    // First research question about a technical topic.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "What is the CAP theorem and why is it important for distributed systems?"
    };

    // Build the conversation history.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the Anthropic Chat API with the conversation history.
    ai:ChatAssistantMessage response1 = check model->chat(messages);
    io:println("Assistant: ", response1.content);

    // Continue the conversation with a follow-up question.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "Which databases prioritize consistency over availability?"
    };
    messages.push(userMessage2);

    // The model uses the full conversation context to answer in relation to CAP theorem.
    ai:ChatAssistantMessage response2 = check model->chat(messages);
    io:println("Assistant: ", response2.content);
}
