# Agent from an AFM definition

[Agent-Flavored Markdown (AFM)](/learn/agent-flavored-markdown/) defines an agent in a Markdown file rather than in framework-specific code. A YAML front matter block holds the configuration, and the body holds the `# Role` and `# Instructions` sections that describe the agent in natural language. The file uses the `.afm` or `.afm.md` extension, and the same file can be run by any AFM implementation.

This example reads an AFM definition, takes the role and the instructions from it as the system prompt of an `ai:Agent`, and runs the agent. The front matter is parsed with the `ballerina/data.yaml` module.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code math_tutor.afm :::

::: code ai_agent_from_afm.bal :::

::: out ai_agent_from_afm.out :::

## Related links
- [The AFM guide](/learn/agent-flavored-markdown/)
- [The AFM specification](https://wso2.github.io/agent-flavored-markdown/specification/)
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
