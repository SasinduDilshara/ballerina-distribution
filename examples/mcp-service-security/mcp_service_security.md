# Model Context Protocol (MCP) service security

MCP servers that expose tools to AI agents often need to be secured, so that only authenticated and authorized clients can discover and call the tools. Since the MCP Streamable HTTP transport is built on HTTP, an MCP service is secured like an `http:Service`: TLS on the listener via the `secureSocket` configuration, and authentication and authorization via the `auth` field of the `httpConfig` configuration in the `@mcp:StreamableHttpServiceConfig` annotation. JWT, OAuth2 introspection, and basic authentication with a file or LDAP user store are supported.

This example demonstrates an MCP server secured with TLS and JWT authentication. The JWT sent in the `Authorization` header is validated against the configured issuer, audience, and signature, and the scopes in the `scp` claim are used for authorization. Requests without a valid JWT, or with a JWT that lacks the required scope, are rejected before the tool is invoked.

::: code mcp_service_security.bal :::

Run the service by executing the command below.

::: out mcp_service_security.server.out :::

Invoke the service using the cURL commands below. The first request carries a JWT with the `admin` scope, the second a JWT with the `developer` scope only, and the third no JWT.

::: out mcp_service_security.client.out :::

## Related links

- [The MCP service example](/learn/by-example/mcp-service/)
- [The MCP tools with HTTP request binding example](/learn/by-example/mcp-service-http-request-binding/)
- [`http:ListenerAuthConfig` type - API documentation](https://lib.ballerina.io/ballerina/http/latest#ListenerAuthConfig)
- [`jwt` module - API documentation](https://lib.ballerina.io/ballerina/jwt/latest/)
