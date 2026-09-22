# Agent evaluation

The behavior of an AI agent depends on the model, the system prompt, and the tools, and can regress as any of these change. The [`ballerina/ai.eval`](https://central.ballerina.io/ballerina/ai.eval/latest) module provides evaluation templates that run an agent and check the outcome, so that agent quality can be verified with ordinary Ballerina tests.

Two families of templates are available. Rule-based templates are scored in code without an LLM, for example, `assertIterationEfficiency`, `assertContentCoverage`, `assertContentSafety`, `assertLatencyPerformance`, and `evaluateToolTrajectory`. LLM-as-a-judge templates use a judge model that returns a score and its reasoning, for example, `evaluateHelpfulness`, `evaluateOutputAccuracy`, `evaluateGroundedness`, and `evaluateSafety`; the evaluation passes when the score reaches the configured threshold. Templates accept either a single query or a recorded conversation thread loaded from an evaluation set with `ai:loadConversationThreads`, which enables comparisons against recorded responses and tool trajectories.

This example demonstrates rule-based and LLM-as-a-judge evaluations of a finance agent written as test functions in the `tests` directory of a package.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

For more information on the underlying module, see the [`ballerina/ai.eval` module](https://lib.ballerina.io/ballerina/ai.eval/latest/).

::: code ai_agent_evaluation.bal :::

::: out ai_agent_evaluation.out :::

## Related links
- [The Agent execution trace example](/learn/by-example/ai-agent-execution-trace/)
- [Test Ballerina code](/learn/test-ballerina-code/write-tests/)
- [The `ballerina/ai.eval` module](https://central.ballerina.io/ballerina/ai.eval/latest)
