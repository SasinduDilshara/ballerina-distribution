import ballerina/io;
import ballerinax/ai.mistral;

// Configure the Mistral API key via Config.toml (never hardcode secrets).
configurable string apiKey = ?;

// Initialize the Mistral model provider.
// Mistral Small is efficient and well-suited for structured extraction tasks.
final mistral:ModelProvider model = check new (apiKey, mistral:MISTRAL_SMALL_LATEST);

// Define the expected code quality analysis result type.
// The `generate` method infers a JSON schema from this type and
// automatically deserializes the response into it.
type CodeQualityReport record {|
    // Overall quality score from 1 (poor) to 10 (excellent)
    int qualityScore;
    // List of identified issues (e.g., "no error handling", "magic numbers")
    string[] issues;
    // Estimated complexity: "low", "medium", or "high"
    string complexity;
    // Whether the code follows common naming conventions
    boolean followsNamingConventions;
    // Top recommendation for improvement
    string topRecommendation;
|};

public function main() returns error? {
    string codeSnippet = string `
        function calculate(x, y, z) {
            var result = x * 0.15 + y * 0.25;
            if(z == 1) {
                result = result * 2
            }
            return result
        }
    `;

    // Use `generate` to analyze code quality and receive a structured report.
    // The model returns JSON matching the CodeQualityReport schema.
    CodeQualityReport report = check model->generate(
        `Analyze the following JavaScript code snippet and provide a code quality report:

        ${codeSnippet}

        Evaluate quality score, list issues, estimate complexity, check naming conventions,
        and provide your top recommendation.`
    );

    io:println("Quality Score: ", report.qualityScore, "/10");
    io:println("Complexity: ", report.complexity);
    io:println("Follows Naming Conventions: ", report.followsNamingConventions);
    io:println("Issues: ", report.issues);
    io:println("Top Recommendation: ", report.topRecommendation);
}
