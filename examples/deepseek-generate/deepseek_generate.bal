import ballerina/io;
import ballerinax/ai.deepseek;

// Configure the DeepSeek API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the DeepSeek model provider.
final deepseek:ModelProvider model = check new (apiKey, deepseek:DEEPSEEK_CHAT);

// Define the expected structured output for content categorization.
// The `generate` method infers a JSON schema from this type and
// automatically deserializes the response into it.
type ArticleMetadata record {|
    // Primary category: "technology", "science", "business", "health", or "other"
    string category;
    // Estimated reading time in minutes
    int readingTimeMinutes;
    // Target audience: "beginner", "intermediate", or "expert"
    string targetAudience;
    // Whether the article has a clear call-to-action for the reader
    boolean hasCallToAction;
    // Up to 5 relevant keywords for SEO
    string[] keywords;
|};

public function main() returns error? {
    string articleExcerpt = string `
        Kubernetes has become the de facto standard for container orchestration,
        but its complexity often intimidates newcomers. In this guide, we walk through
        setting up your first cluster, deploying a simple application, and configuring
        autoscaling. By the end, you'll have a working cluster and understand the core
        concepts of pods, services, and deployments. No prior Kubernetes experience needed.
    `;

    // Use `generate` with a typed return to categorize the article and extract metadata.
    // DeepSeek returns JSON matching the ArticleMetadata schema.
    ArticleMetadata metadata = check model->generate(
        `Analyze the following article excerpt and extract structured metadata:

        "${articleExcerpt}"

        Determine the category, estimated reading time, target audience,
        whether there is a call-to-action, and up to 5 SEO keywords.`
    );

    io:println("Category: ", metadata.category);
    io:println("Reading Time: ", metadata.readingTimeMinutes, " min");
    io:println("Target Audience: ", metadata.targetAudience);
    io:println("Has Call-to-Action: ", metadata.hasCallToAction);
    io:println("Keywords: ", metadata.keywords);
}
