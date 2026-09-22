# Agent with typed input and output

Agents are not limited to exchanging plain text. The `run` method of an `ai:Agent` accepts any `anydata` value (e.g., a record) or a prompt template as the query, so structured input can be passed directly. The method is also dependently typed: the expected type at the call site determines how the agent's final response is bound. When a structured type such as a record is expected, the JSON schema of the type is sent to the LLM and the response is validated and converted to that type. When `string` is expected, the raw answer is returned, and when `ai:Trace` is expected, the full execution trace is returned.

This makes it possible to integrate agents into typed Ballerina code without parsing free-form text, and to get compile-time checked access to the fields of the result.

This example demonstrates a trip planner agent that accepts a request record and returns a typed itinerary, and also returns a plain string when that is the expected type.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_typed_input_output.bal :::

::: out ai_agent_typed_input_output.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [The Direct LLM calls example](/learn/by-example/direct-llm-calls/)
