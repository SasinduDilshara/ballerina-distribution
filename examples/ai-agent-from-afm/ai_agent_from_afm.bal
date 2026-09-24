import ballerina/ai;
import ballerina/data.yaml;
import ballerina/io;

// Agent-Flavored Markdown (AFM) defines an agent in a Markdown file instead of framework
// specific code: a YAML front matter block holds the configuration, and the body holds the
// `# Role` and `# Instructions` sections that describe the agent in natural language.
// The fields of the front matter used by this example. Every AFM field is optional, and the
// record is open, so the fields that are not read here are ignored.
type AfmDefinition record {
    string name = "Agent";
    int max_iterations = 10;
};

public function main() returns error? {
    string[] lines = re `\n`.split(check io:fileReadString("math_tutor.afm"));

    // The front matter is the optional YAML block between the first two `---` lines.
    AfmDefinition afm = {};
    int bodyStart = 0;
    if lines.length() > 0 && lines[0].trim() == "---" {
        int? frontMatterEnd = ();
        foreach int i in 1 ..< lines.length() {
            if lines[i].trim() == "---" {
                frontMatterEnd = i;
                break;
            }
        }
        if frontMatterEnd is () {
            return error("Invalid AFM file: the front matter is not terminated");
        }
        afm = check yaml:parseString(string:'join("\n", ...lines.slice(1, frontMatterEnd)));
        bodyStart = frontMatterEnd + 1;
    }

    // The `# Role` and `# Instructions` sections of the body become the system prompt.
    string[] body = lines.slice(bodyStart);
    ai:Agent tutor = check new ({
        systemPrompt: {
            role: check getSection(body, "# Role"),
            instructions: check getSection(body, "# Instructions")
        },
        model: check ai:getDefaultModelProvider(),
        maxIter: afm.max_iterations
    });

    io:println("Agent: ", afm.name);
    string response = check tutor.run("How do I find the area of a circle with a radius of 3?");
    io:println(response);
}

// Returns the content of a top-level section, which runs until the next top-level heading.
// A heading is matched only at the start of a line, so nested headings stay part of the content.
isolated function getSection(string[] body, string heading) returns string|error {
    string[] content = [];
    boolean inSection = false;
    foreach string line in body {
        if line.startsWith("# ") {
            if inSection {
                break;
            }
            inSection = line.trim() == heading;
        } else if inSection {
            content.push(line);
        }
    }
    if !inSection {
        return error(string `Invalid AFM file: the '${heading}' section is missing`);
    }
    return string:'join("\n", ...content).trim();
}
