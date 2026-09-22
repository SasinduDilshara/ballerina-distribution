import ballerina/ai;
import ballerina/io;
import ballerinax/ai.azure;

// The connection details for the model provider. Add them to the `Config.toml` file.
configurable string azureServiceUrl = ?;
configurable string azureApiKey = ?;
configurable string azureDeploymentId = ?;

// Initialize a model provider for a specific LLM provider using your own keys.
// This example uses Azure OpenAI; other `ballerinax/ai.<provider>` modules follow the same pattern.
// With the legacy Azure OpenAI URL (`https://<resource>.openai.azure.com/openai`),
// pass the `apiVersion` argument too.
final ai:ModelProvider model = check new azure:OpenAiModelProvider(azureServiceUrl, azureApiKey,
        azureDeploymentId,
        // Set `temperature` to `()` for models that do not support it (e.g., GPT-5 series).
        temperature = 0.2);

type Summary record {|
    # A short title for the text
    string title;
    # The key points, one sentence each
    string[] keyPoints;
|};

public function main() returns error? {
    string text = string `Ballerina is an open-source, cloud-native programming language
        optimized for integration. It has first-class support for network protocols, data
        formats such as JSON and XML, and concurrency. The language also provides built-in
        abstractions to work with large language models, agents, and retrieval-augmented
        generation.`;

    // Since the provider implements `ai:ModelProvider`, the `generate` method works exactly
    // the same as with the default model provider. The response is bound to the expected type.
    Summary summary = check model->generate(`Summarize the following text: ${text}`);
    io:println("Title: ", summary.title);
    foreach string keyPoint in summary.keyPoints {
        io:println("- ", keyPoint);
    }
}
