# Natural functions

A natural function is a function whose body is written in natural language instead of code. The function signature (the parameters and the return type) is declared in Ballerina, and the body is a natural expression that describes the logic in English. At runtime, the parameters are available in the prompt via interpolations, the return type is converted to a JSON schema and sent to the LLM along with the prompt, and the response is bound to the return type.

Natural functions let you keep the typed contract of a regular function while delegating the logic to an LLM, so callers use them exactly like any other function. Any `ai:ModelProvider` implementation can be used, including the default model provider.

This example demonstrates a natural function that analyzes a customer review and returns a typed result.

> Note: This example uses the default model provider implementation. To generate the necessary configuration, open up the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`), and run the `Configure default WSO2 Model Provider` command to add your configuration to the `Config.toml` file. If not already logged in, log in to the Ballerina Copilot when prompted. Alternatively, to use your own keys, use the relevant `ballerinax/ai.<provider>` model provider implementation.

> Note: This feature is supported on Swan Lake Update 13 or newer versions. This is currently an experimental feature and requires the `--experimental` flag to be used with `bal` commands.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code natural_functions.bal :::

::: out natural_functions.out :::

## Related links

- [The Natural expressions example](/learn/by-example/natural-expressions/)
- [The Natural expressions with a specific model provider example](/learn/by-example/natural-expressions-with-model-provider/)
- [Natural Language is Code: A hybrid approach with Natural Programming](https://blog.ballerina.io/posts/2025-04-26-introducing-natural-programming/)
- [The `ballerina/ai.np` module](https://central.ballerina.io/ballerina/ai.np/latest)
