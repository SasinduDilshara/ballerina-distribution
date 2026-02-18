import ballerina/io;
import ballerinax/ai.azure;

// Configure Azure OpenAI connection details via Config.toml.
configurable string serviceUrl = ?;
configurable string apiKey = ?;
configurable string deploymentId = ?;
configurable string apiVersion = ?;

// Initialize the Azure OpenAI model provider.
final azure:OpenAiModelProvider model = check new (serviceUrl, apiKey, deploymentId, apiVersion);

// Define the expected structured response type for content moderation.
// The `generate` method maps the LLM's JSON response directly to this record.
type ContentReview record {|
    // Overall quality score from 1 (poor) to 10 (excellent)
    int qualityScore;
    // Sentiment of the content: "positive", "neutral", or "negative"
    string sentiment;
    // List of key topics covered in the content
    string[] keyTopics;
    // Whether the content contains any inappropriate material
    boolean flagged;
    // Brief improvement suggestion if quality score is below 7
    string? suggestion;
|};

public function main() returns error? {
    string articleContent = string `
        Ballerina's query expressions bring SQL-like syntax into the language, allowing
        developers to filter, transform, and aggregate data from lists and tables using
        intuitive 'from', 'where', 'select', and 'group by' clauses. This makes data
        processing workflows more readable and less error-prone compared to imperative loops.
    `;

    // Use `generate` with a typed return to get a structured ContentReview.
    // The model infers the JSON schema from the return type and populates it.
    ContentReview review = check model->generate(
        `Review the following technical article content and provide structured feedback:

        ${articleContent}

        Evaluate the quality, detect the sentiment, extract key topics, check for
        inappropriate material, and suggest improvements if needed.`
    );

    io:println("Quality Score: ", review.qualityScore, "/10");
    io:println("Sentiment: ", review.sentiment);
    io:println("Key Topics: ", review.keyTopics);
    io:println("Flagged: ", review.flagged);
    if review.suggestion != () {
        io:println("Suggestion: ", review.suggestion);
    }
}
