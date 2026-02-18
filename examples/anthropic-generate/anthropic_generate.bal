import ballerina/io;
import ballerinax/ai.anthropic;

// Configure the Anthropic API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the Anthropic model provider.
// Claude Haiku is a lightweight, fast model well-suited for classification tasks.
final anthropic:ModelProvider model = check new (apiKey, anthropic:CLAUDE_HAIKU_4_5);

// Define the expected sentiment analysis result type.
// The `generate` method infers a JSON schema from this type and
// automatically deserializes the structured response.
type SentimentResult record {|
    // Overall sentiment: "positive", "neutral", or "negative"
    string sentiment;
    // Confidence score from 0.0 (least confident) to 1.0 (most confident)
    float confidence;
    // Dominant emotion detected (e.g., "satisfaction", "frustration", "joy")
    string dominantEmotion;
    // Key phrases that influenced the sentiment classification
    string[] keyPhrases;
|};

public function main() returns error? {
    string customerReview = string `
        I've been using this project management tool for three months now.
        The interface is intuitive and the collaboration features are excellent.
        However, the mobile app is quite slow and crashes occasionally.
        Overall, it saves me a lot of time, but I hope they fix the mobile issues soon.
    `;

    // Use `generate` with a typed return to get a structured SentimentResult.
    // Claude analyzes the review and returns JSON matching the SentimentResult schema.
    SentimentResult result = check model->generate(
        `Analyze the sentiment of the following customer review and provide structured feedback:

        "${customerReview}"

        Identify the overall sentiment, confidence level, dominant emotion, and key phrases
        that contributed to the sentiment.`
    );

    io:println("Sentiment: ", result.sentiment);
    io:println("Confidence: ", result.confidence);
    io:println("Dominant Emotion: ", result.dominantEmotion);
    io:println("Key Phrases: ", result.keyPhrases);
}
