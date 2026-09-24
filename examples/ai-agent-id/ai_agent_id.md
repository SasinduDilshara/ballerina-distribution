# Agent ID

An agent that calls external services on a user's behalf needs an identity of its own, so that its access can be granted, restricted, and audited separately from the application that hosts it. The `credential` field of the agent configuration takes an `ai:Credential`, which holds the ID and secret assigned to the agent by the authorization server.

A tool declares the authorization it needs with the `auth` field of the `@ai:AgentTool` annotation. Before invoking such a tool, the agent obtains an access token from the authorization server using its own credentials and the scopes declared for that tool, and places the token in the `ai:Context` of the run. The tool reads it with `getAccessToken`, passing its own tool name.

This example gives a scheduling agent an identity, and a calendar tool that is called with a token obtained for that identity.

> Note: This example requires an agent identity registered with an authorization server, and an OAuth 2.0 client for the application. Add the agent ID and secret, the authorization server URL, the client credentials, and the redirect URI to the `Config.toml` file. It also uses the default model provider implementation; run the `Configure default WSO2 Model Provider` command from the VS Code command palette (`Ctrl` + `Shift` + `P` or `command` + `shift` + `P`) to add that configuration.

For more information on the underlying module, see the [`ballerina/ai` module](https://lib.ballerina.io/ballerina/ai/latest/).

::: code ai_agent_id.bal :::

## Related links
- [The Passing context to agent tools example](/learn/by-example/ai-agent-tool-context/)
- [The Agent with human-in-the-loop example](/learn/by-example/ai-agent-human-in-the-loop/)
- [The Agent with external endpoint integration example](/learn/by-example/ai-agent-external-endpoint-integration/)
