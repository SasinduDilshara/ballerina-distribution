import ballerina/io;
import ballerinax/ai.ollama;

// Initialize the Ollama model provider.
// Ollama runs locally — no API key or internet connection required.
// Replace "llama3.2" with any model you have pulled via `ollama pull <model>`.
final ollama:ModelProvider model = check new ("llama3.2");

// Define the expected structured classification result.
// The `generate` method infers a JSON schema from this type and
// automatically deserializes the response into it.
type DocumentClassification record {|
    // Primary category: "technical", "legal", "financial", "hr", or "other"
    string category;
    // Subcategory for finer classification (e.g., "API documentation", "contract")
    string subcategory;
    // Confidence level: "high", "medium", or "low"
    string confidence;
    // Key terms that indicate the document's subject
    string[] keyTerms;
    // Whether the document appears to contain sensitive information
    boolean containsSensitiveInfo;
|};

public function main() returns error? {
    string documentExcerpt = string `
        This Amendment to the Service Agreement ("Amendment") is entered into as of
        January 1, 2025, by and between Acme Corp ("Provider") and Beta Ltd ("Client").
        Both parties agree to modify Section 4.2 of the original agreement dated
        March 15, 2023, to extend the contract term by an additional twelve (12) months.
        All other terms and conditions of the original agreement remain in full force.
    `;

    // Use `generate` with a typed return to classify the document locally.
    // No data is sent to external services — classification happens on-device.
    DocumentClassification classification = check model->generate(
        `Classify the following document excerpt and extract key metadata:

        "${documentExcerpt}"

        Determine the category, subcategory, confidence level, key terms,
        and whether the document contains sensitive information.`
    );

    io:println("Category: ", classification.category);
    io:println("Subcategory: ", classification.subcategory);
    io:println("Confidence: ", classification.confidence);
    io:println("Key Terms: ", classification.keyTerms);
    io:println("Contains Sensitive Info: ", classification.containsSensitiveInfo);
}
