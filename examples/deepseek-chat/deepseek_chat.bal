import ballerina/ai;
import ballerina/io;
import ballerinax/ai.deepseek;

// Configure the DeepSeek API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the DeepSeek model provider with the DeepSeek Chat model.
final deepseek:ModelProvider model = check new (apiKey, deepseek:DEEPSEEK_CHAT);

public function main() returns error? {
    // Define a system message for a personal financial planning assistant.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a practical personal finance advisor. Help users plan budgets and savings goals with clear, actionable advice."
    };

    // First message: state the savings goal and ask if it is achievable.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "I earn $4,000 per month after tax and want to save $10,000 in the next 12 months. Is that realistic?"
    };

    // Build conversation history with the system context and first message.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the DeepSeek Chat API — the model reasons about the numbers and gives an assessment.
    ai:ChatAssistantMessage response1 = check model->chat(messages, []);
    io:println("Advisor: ", response1.content);

    // Follow up with a breakdown of current expenses — the model uses the prior context
    // (income and savings goal) to give tailored advice.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "My monthly expenses are: rent $1,200, groceries $400, transport $200, subscriptions $100. What should I adjust?"
    };
    messages.push(userMessage2);

    // The model reasons over all prior context to suggest a concrete budget adjustment.
    ai:ChatAssistantMessage response2 = check model->chat(messages, []);
    io:println("Advisor: ", response2.content);
}
