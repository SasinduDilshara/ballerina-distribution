import ballerina/ai;
import ballerina/io;

type Order record {|
    string id;
    decimal total;
    string status;
|};

isolated map<Order> orders = {
    "ORD-1001": {id: "ORD-1001", total: 120.50, status: "delivered"}
};

# Gets the details of an order.
# + orderId - The order ID
# + return - The order details, or an error if the order is not found
@ai:AgentTool
isolated function getOrder(string orderId) returns Order|error {
    lock {
        Order? 'order = orders[orderId];
        if 'order is () {
            return error("Order not found: " + orderId);
        }
        return 'order.clone();
    }
}

// Mark the tool as requiring human approval. The agent pauses before calling this tool
// and resumes only after a human approves or rejects the proposed call.
# Issues a refund for an order. This action is irreversible.
# + orderId - The order ID
# + amount - The amount to refund
# + return - A confirmation message, or an error if the order is not found
@ai:AgentTool {requiresApproval: true}
isolated function issueRefund(string orderId, decimal amount) returns string|error {
    lock {
        Order? 'order = orders[orderId];
        if 'order is () {
            return error("Order not found: " + orderId);
        }
        'order.status = "refunded";
    }
    return string `A refund of ${amount} has been issued for order ${orderId}`;
}

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: string `You help customers with their orders. Look up orders and
            issue refunds when asked. Keep answers brief.`
    },
    // Use the default model provider (with configuration added via a Ballerina VS Code command).
    model: check ai:getDefaultModelProvider(),
    tools: [getOrder, issueRefund]
});

public function main() returns error? {
    string sessionId = "customer-7";
    string|ai:Error result = supportAgent.run("Please refund my order ORD-1001 in full.", sessionId);

    // When the agent proposes a call to a tool that requires approval, the run pauses and
    // returns an `ai:ApprovalRequiredError` that describes the pending tool call(s).
    if result is ai:ApprovalRequiredError {
        map<ai:HumanDecision> decisions = {};
        foreach ai:ApprovalRequest request in result.detail().requests {
            io:println(string `Approval required to call '${request.toolName}' with arguments ${
                    request.arguments.toJsonString()}`);
            // A human reviews the proposed call. Here, the decision is read from the console.
            string answer = io:readln("Approve? (y/n): ");
            decisions[request.id] = answer.toLowerAscii() == "y" ?
                    {outcome: ai:APPROVE} :
                    {outcome: ai:REJECT, reason: "Rejected by the support supervisor"};
        }

        // Resume the paused run with the decisions, using the same session ID. The agent
        // executes the approved tool calls, learns about the rejected ones, and continues
        // to produce the final response.
        ai:Resume resume = {decisions: decisions.cloneReadOnly()};
        string response = check supportAgent.run(resume, sessionId);
        io:println("Agent: ", response);
    } else {
        io:println("Agent: ", check result);
    }
}
