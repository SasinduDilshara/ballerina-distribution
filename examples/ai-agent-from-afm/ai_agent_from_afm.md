# Deploy an agent from an AFM file

[Agent-Flavored Markdown (AFM)](/learn/agent-flavored-markdown/) defines an agent in a Markdown file rather than in code. A YAML front matter block holds the configuration, and the body holds the `# Role` and `# Instructions` sections that describe the agent in natural language. An interpreter reads the file and builds the agent from it, so deploying an agent means shipping a definition and an interpreter, with no application code to write or compile.

The agent below is a standup assistant reachable over Telegram. It reads the user's GitHub activity and Google Calendar through three MCP servers, and it loads two skills that hold the longer procedures for composing a standup update and for booking time.

::: code standup_assistant.afm :::

The definition here uses the `.afm` extension. The specification accepts `.afm` and `.afm.md` equally, so the same file can carry either.

The front matter names everything the runtime needs. The `model` section selects Claude and reads its key from the environment. The `interfaces` section makes the agent a Telegram bot that polls for new messages, and builds each user prompt from the incoming event with `http:payload` references. The `tools.mcp` section connects three MCP servers, two launched over stdio and one reached over HTTP, and `tool_filter` narrows the GitHub server to the three tools this agent should be able to call. No credential appears in the file itself; every one of them is an `env:` variable reference resolved when the agent loads.

## Add the skills

The `skills` field points at a directory next to the definition. Each skill is a subdirectory holding a `SKILL.md` file whose front matter carries a `name` and a `description`. The interpreter reads only those two fields up front and loads the body when the agent decides the skill applies, which keeps the system prompt small.

```markdown
---
name: standup-update
description: Compose a daily standup update from the user's recent GitHub pull request activity.
---

# Standup update

Build the update from live GitHub data only.

1. Call `get_me` to resolve the current GitHub user.
...
```

## Build the image

Bake the definition and the skills into an image built on the interpreter. The image already provides `uv` and `npx`, so the stdio MCP servers can be launched from inside the container.

::: code Dockerfile :::

```bash
docker build -t standup-assistant:0.1.0 .
```

Validate the definition before shipping it. This parses the file, resolves the skills, and prints the interfaces and MCP servers it found, without contacting the model.

```bash
docker run --rm --entrypoint afm standup-assistant:0.1.0 validate /app/agent.afm
```

## Run it

Pass the credentials at run time, named by the `env:` variable references in the definition. This agent needs `ANTHROPIC_API_KEY`, `TELEGRAM_BOT_TOKEN`, `GITHUB_TOKEN`, and `GOOGLE_OAUTH_CREDENTIALS`, and `TELEGRAM_MCP_DIR` pointing at the Telegram MCP server.

```bash
docker run -d --name standup-assistant --restart unless-stopped \
  -e ANTHROPIC_API_KEY -e TELEGRAM_BOT_TOKEN -e GITHUB_TOKEN -e GOOGLE_OAUTH_CREDENTIALS \
  -e TELEGRAM_MCP_DIR=/app/telegram-mcp \
  -v /opt/telegram-mcp:/app/telegram-mcp:ro \
  standup-assistant:0.1.0
```

A few things follow from this particular definition. The agent polls Telegram rather than receiving webhooks, so it needs outbound network access but no published port and no inbound route. One replica should run at a time, because a second one would poll the same chat and answer twice. The calendar server is fetched by `npx` on each start, so vendor it into the image for a deployment that must not depend on a package registry being reachable. Secrets belong in whatever secret store the platform provides rather than in the image or in a compose file, and rotating one means restarting the container, since those references resolve when the agent loads.

> Note: `platformchat`, the interface type this agent uses, is defined in version 0.4.0 of the specification but is not yet implemented by either reference interpreter, both of which accept only `consolechat`, `webchat`, and `webhook`. Validating this definition against the published image today reports: `Input tag 'platformchat' found using 'type' does not match any of the expected tags: 'consolechat', 'webchat', 'webhook'`. Changing `interfaces` to `- type: webchat` runs the same agent, with the same tools and skills, as a web chat service on port 8085.

For more information on the format, see the [AFM specification](https://wso2.github.io/agent-flavored-markdown/specification/).

## Related links
- [The AFM guide](/learn/agent-flavored-markdown/)
- [The AFM specification](https://wso2.github.io/agent-flavored-markdown/specification/)
- [The MCP service example](/learn/by-example/mcp-service/)
