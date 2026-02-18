import ballerina/io;
import ballerinax/ai.openai;

// Configure the OpenAI API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the OpenAI model provider.
// GPT-4o-mini is a fast, cost-effective model well-suited for structured generation tasks.
final openai:ModelProvider model = check new (apiKey, openai:GPT_4O_MINI);

// Define the expected structured response type.
// The `generate` method infers a JSON schema from this type and
// automatically binds the model response to it.
type BlogMetadata record {|
    // A suitable title for the blog post
    string title;
    // A list of relevant topic tags (3-5 tags recommended)
    string[] tags;
    // A one-sentence summary of the content
    string summary;
|};

public function main() returns error? {
    string blogContent = string `
        Ballerina is a cloud-native programming language designed for integration.
        It has built-in support for network protocols like HTTP, gRPC, and WebSockets.
        The language treats network interactions as first-class citizens, making it
        ideal for building microservices and APIs. Ballerina also features a visual
        diagram representation of the code, making it easier to understand data flows.
    `;

    // Use `generate` with a typed return to get a structured BlogMetadata record.
    // The model receives the JSON schema for `BlogMetadata` and returns a
    // matching JSON object that Ballerina automatically deserializes.
    BlogMetadata metadata = check model->generate(
        `Analyze the following blog content and extract metadata:

        ${blogContent}

        Provide a suitable title, 3-5 relevant tags, and a one-sentence summary.`
    );

    io:println("Title: ", metadata.title);
    io:println("Tags: ", metadata.tags);
    io:println("Summary: ", metadata.summary);
}
