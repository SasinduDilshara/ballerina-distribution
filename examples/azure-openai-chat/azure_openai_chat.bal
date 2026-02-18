import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// Configure Azure OpenAI connection details via Config.toml.
// These values are available in the Azure portal under your Azure OpenAI resource.
configurable string serviceUrl = ?;
configurable string apiKey = ?;
configurable string deploymentId = ?;
configurable string apiVersion = ?;

// Initialize the Azure OpenAI model provider.
// Azure OpenAI uses a deployment ID (the name you gave your deployed model)
// rather than a model type enum.
final azure:OpenAiModelProvider model = check new (serviceUrl, apiKey, deploymentId, apiVersion);

public function main() returns error? {
    // Define a system message that sets the assistant's persona.
    ai:ChatSystemMessage systemMessage = {
        role: ai:SYSTEM,
        content: "You are a helpful HR assistant for a company. Answer employee questions clearly and concisely."
    };

    // First employee question about leave policy.
    ai:ChatUserMessage userMessage1 = {
        role: ai:USER,
        content: "How many days of annual leave am I entitled to as a full-time employee?"
    };

    // Build the conversation history with the system context and first message.
    ai:ChatMessage[] messages = [systemMessage, userMessage1];

    // Call the Azure OpenAI Chat API.
    ai:ChatAssistantMessage response1 = check model->chat(messages, []);
    io:println("HR Assistant: ", response1.content);

    // Append the assistant's reply to the history and ask a follow-up.
    messages.push(response1);
    ai:ChatUserMessage userMessage2 = {
        role: ai:USER,
        content: "Can I carry unused leave days to the next year?"
    };
    messages.push(userMessage2);

    // The model uses the full history to give a relevant, in-context response.
    ai:ChatAssistantMessage response2 = check model->chat(messages, []);
    io:println("HR Assistant: ", response2.content);
}
