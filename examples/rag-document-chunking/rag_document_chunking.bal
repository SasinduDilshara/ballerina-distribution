import ballerina/ai;
import ballerina/io;

// Documents of different types. The `mimeType` metadata identifies the type of each document.
final ai:TextDocument[] documents = [
    {
        metadata: {fileName: "leave_policy.md", mimeType: "text/markdown"},
        content: string `# Leave policy

## Annual leave

Full-time employees are entitled to 20 days of paid annual leave per year.

## Sick leave

Employees are entitled to 10 days of paid sick leave per year.`
    },
    {
        metadata: {fileName: "travel_policy.html", mimeType: "text/html"},
        content: string `<h1>Travel policy</h1>
<h2>Booking</h2>
<p>Business travel must be booked two weeks in advance.</p>
<h2>Expenses</h2>
<p>Meals are reimbursed up to 60 USD per day.</p>`
    },
    {
        metadata: {fileName: "code_of_conduct.txt", mimeType: "text/plain"},
        content: string `Treat colleagues, customers, and partners with respect.
Harassment is not tolerated. Report any concerns to the HR team.`
    }
];

// Select a chunker based on the MIME type of the document. Each chunker uses the
// structure of the document type (e.g., headers) to produce meaningful chunks and
// recursively falls back to smaller units (e.g., sentences) when a chunk is too large.
function getChunker(string? mimeType) returns ai:Chunker {
    match mimeType {
        "text/markdown" => {
            return new ai:MarkdownChunker(maxChunkSize = 100, maxOverlapSize = 20);
        }
        "text/html" => {
            return new ai:HtmlChunker(maxChunkSize = 100, maxOverlapSize = 20);
        }
        _ => {
            return new ai:GenericRecursiveChunker(maxChunkSize = 100, maxOverlapSize = 20,
                    strategy = ai:SENTENCE);
        }
    }
}

public function main() returns error? {
    foreach ai:TextDocument document in documents {
        ai:Chunker chunker = getChunker(document.metadata?.mimeType);
        ai:Chunk[] chunks = check chunker.chunk(document);
        io:println(string `${document.metadata?.fileName ?: ""} (${document.metadata?.mimeType ?: ""}): ${
                chunks.length()} chunks`);
        foreach ai:Chunk chunk in chunks {
            // Chunks carry metadata such as the chunk index and the section header.
            string content = re `\s+`.replaceAll(chunk.content.toString(), " ").trim();
            io:println(string `  [${chunk.metadata?.index ?: 0}] header: ${chunk.metadata?.header ?: "-"} | ${
                    content}`);
        }
    }
}
