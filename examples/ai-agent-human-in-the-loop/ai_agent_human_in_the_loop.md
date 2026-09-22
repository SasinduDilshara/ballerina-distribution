# Human-in-the-loop tool approval

Some tool calls have consequences that should not be left to the LLM alone, such as issuing refunds, sending messages, or deleting data. Ballerina agents support human-in-the-loop approval for such tools. A tool is marked as requiring approval via the `requiresApproval` field of the `@ai:AgentTool` annotation (or `ai:ToolConfig`). The value can be `true` to always require approval, or an `isolated` function with the same parameters as the tool that decides per call based on the proposed arguments.

When the agent proposes a call to such a tool, the run pauses and returns an `ai:ApprovalRequiredError` that carries one `ai:ApprovalRequest` per pending call, including the tool name and the proposed arguments. A human (or an approval workflow) reviews the requests, and the run is resumed by calling `run` with an `ai:Resume` value that maps each request ID to an `ai:HumanDecision` (approve or reject, with an optional reason), using the same session ID. The paused state is checkpointed in the agent's memory store, so with a persistent store the run can be resumed after a restart or from a different process.

This example demonstrates a customer support agent whose refund tool requires approval, with the decision read from the console.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_human_in_the_loop.bal :::

::: out ai_agent_human_in_the_loop.out :::

## Related links
- [The Agent with local tools example](/learn/by-example/ai-agent-local-tools/)
- [The Agent with persistent memory example](/learn/by-example/ai-agent-persistent-memory/)
- [The Chat client example](/learn/by-example/ai-chat-client/)
