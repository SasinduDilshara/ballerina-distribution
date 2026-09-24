FROM ghcr.io/wso2/afm-langchain-interpreter:latest

# Bake the agent definition and its skills into the image, so that a running container
# carries no configuration of its own and every deployment is identical. Skill paths in the
# definition resolve against the location of the definition, which is `/app` here.
COPY standup_assistant.afm /app/agent.afm
COPY skills /app/skills

# Credentials are never baked in. They arrive as environment variables at run time, named
# by the `${env:...}` references in the agent definition.
CMD ["run", "/app/agent.afm"]
