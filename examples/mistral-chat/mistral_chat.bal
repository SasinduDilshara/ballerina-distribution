import ballerina/ai;
import ballerina/io;
import ballerinax/ai.mistral;

// Configure the Mistral API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the Mistral model provider with the Mistral Large model.
final mistral:ModelProvider model = check new (apiKey, mistral:MISTRAL_LARGE_LATEST);

public function main() returns error? {
    // Define a system message for a code review assistant.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are an expert code reviewer. Provide concise, actionable feedback on code quality, best practices, and potential issues."
    };

    // First message: submit code for review.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: string `Please review this Python function:

def get_user(user_id):
    conn = db.connect('postgresql://prod-db/myapp')
    result = conn.execute('SELECT * FROM users WHERE id = ' + user_id)
    return result.fetchone()`
    };

    // Build conversation history with system context and first message.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the Mistral Chat API.
    ai:ChatAssistantMessage response1 = check model->chat(messages);
    io:println("Reviewer: ", response1.content);

    // Follow up for a corrected version.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "Can you show me a corrected version that addresses all the issues?"
    };
    messages.push(userMessage2);

    // The model uses the full history to provide a targeted fix.
    ai:ChatAssistantMessage response2 = check model->chat(messages);
    io:println("Reviewer: ", response2.content);
}
