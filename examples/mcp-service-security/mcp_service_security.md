# Model Context Protocol (MCP) service security

MCP servers that expose tools to AI agents often need to be secured, so that only authenticated and authorized clients can discover and call the tools. Since the MCP Streamable HTTP transport is built on HTTP, an MCP service can be secured with the same mechanisms as an `http:Service`: TLS on the listener via the `secureSocket` configuration, and authentication and authorization via the `auth` field of the `httpConfig` configuration in the `@mcp:StreamableHttpServiceConfig` annotation. Basic authentication (file or LDAP user store), JWT, and OAuth2 are supported.

This example demonstrates an MCP server secured with TLS and basic authentication using the file user store, with scope-based authorization. Requests without valid credentials or without the required scope are rejected before the tool is invoked.

::: code mcp_service_security.bal :::

>**Info:** As a prerequisite to running the service, populate the `Config.toml` file correctly with the user information as shown below.

::: code Config.toml :::

Run the service by executing the command below.

::: out mcp_service_security.server.out :::

Invoke the service using the cURL commands below. The first request uses a user with the `admin` scope, the second uses a user without it, and the third sends no credentials.

::: out mcp_service_security.client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP tools with HTTP request binding example](/learn/by-example/mcp-service-http-request-binding/)
- [`http:ListenerAuthConfig` type - API documentation](https://lib.ballerina.io/ballerina/http/latest#ListenerAuthConfig)
- [`auth` module - API documentation](https://lib.ballerina.io/ballerina/auth/latest/)
