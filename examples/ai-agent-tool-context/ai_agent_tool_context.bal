import ballerina/ai;
import ballerina/io;

type Order record {|
    string id;
    string customerId;
    string status;
|};

final readonly & Order[] orders = [
    {id: "ORD-1001", customerId: "CUST-7", status: "delivered"},
    {id: "ORD-1002", customerId: "CUST-9", status: "in transit"},
    {id: "ORD-1003", customerId: "CUST-7", status: "processing"}
];

# Lists the orders of the signed-in customer.
# + context - The context carrying the ID of the signed-in customer
# + return - The orders of the customer
@ai:AgentTool
isolated function listMyOrders(ai:Context context) returns Order[]|error {
    // Read the value that the caller placed in the context.
    string customerId = check context.getWithType("customerId");
    return from Order 'order in orders
        where 'order.customerId == customerId
        select 'order;
}

final ai:Agent supportAgent = check new ({
    systemPrompt: {
        role: "Customer Support Agent",
        instructions: "You answer questions about the orders of the signed-in customer. Keep answers brief."
    },
    model: check ai:getDefaultModelProvider(),
    tools: [listMyOrders]
});

public function main() returns error? {
    // The ID of the signed-in customer comes from the application, not from the conversation,
    // so it is passed through the context rather than the query.
    ai:Context context = new;
    context.set("customerId", "CUST-7");
    string response = check supportAgent.run("What is the status of my orders?", "customer-7", context);
    io:println(response);

    // The same agent serves another customer by running it with a different context.
    ai:Context otherContext = new;
    otherContext.set("customerId", "CUST-9");
    response = check supportAgent.run("What is the status of my orders?", "customer-9", otherContext);
    io:println("\n", response);
}
