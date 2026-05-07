import ballerina/io;
import ballerinax/hubspot.automation.actions;

// Configurable variables for authentication
configurable string accessToken = ?;

// Application ID for HubSpot app
configurable int:Signed32 appId = ?;

public function main() returns error? {
    // Initialize the HubSpot Automation Actions client with bearer token authentication
    actions:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    actions:Client hubspotClient = check new (config);
    
    io:println("=== HubSpot Workflow Action Lifecycle Management ===\n");
    
    // Step 1: Create a new custom action definition with specific input fields
    io:println("Step 1: Creating a new custom action definition...");
    
    actions:PublicActionDefinitionEgg newActionDefinition = {
        actionUrl: "https://example.com/api/workflow-action",
        inputFields: [
            {
                isRequired: true,
                typeDefinition: {
                    name: "contactEmail",
                    'type: "string",
                    options: [],
                    externalOptions: false,
                    externalOptionsReferenceType: ()
                },
                supportedValueTypes: ["STATIC_VALUE", "OBJECT_PROPERTY"]
            },
            {
                isRequired: false,
                typeDefinition: {
                    name: "notificationMessage",
                    'type: "string",
                    options: [],
                    externalOptions: false,
                    externalOptionsReferenceType: ()
                },
                supportedValueTypes: ["STATIC_VALUE"]
            },
            {
                isRequired: true,
                typeDefinition: {
                    name: "priority",
                    'type: "enumeration",
                    options: [
                        {
                            value: "HIGH",
                            label: "High Priority",
                            displayOrder: 1,
                            hidden: false,
                            description: "High priority notification",
                            doubleData: 0.0,
                            readOnly: false
                        },
                        {
                            value: "MEDIUM",
                            label: "Medium Priority",
                            displayOrder: 2,
                            hidden: false,
                            description: "Medium priority notification",
                            doubleData: 0.0,
                            readOnly: false
                        },
                        {
                            value: "LOW",
                            label: "Low Priority",
                            displayOrder: 3,
                            hidden: false,
                            description: "Low priority notification",
                            doubleData: 0.0,
                            readOnly: false
                        }
                    ],
                    externalOptions: false,
                    externalOptionsReferenceType: ()
                },
                supportedValueTypes: ["STATIC_VALUE"]
            }
        ],
        functions: [],
        labels: {
            "en": {
                actionName: "Send Custom Notification",
                actionDescription: "Sends a custom notification to the specified contact with configurable priority levels",
                inputFieldLabels: {
                    "contactEmail": "Contact Email Address",
                    "notificationMessage": "Notification Message",
                    "priority": "Priority Level"
                },
                inputFieldDescriptions: {
                    "contactEmail": "The email address of the contact to notify",
                    "notificationMessage": "The message content to send in the notification",
                    "priority": "Select the urgency level for this notification"
                }
            }
        },
        objectTypes: ["CONTACT"],
        published: false
    };
    
    actions:PublicActionDefinition createdAction = check hubspotClient->/[appId].post(newActionDefinition);
    
    io:println("Successfully created action definition!");
    io:println("  - Action ID: " + createdAction.id);
    io:println("  - Action URL: " + createdAction.actionUrl);
    io:println("  - Published: " + createdAction.published.toString());
    io:println("  - Number of input fields: " + createdAction.inputFields.length().toString());
    io:println();
    
    string definitionId = createdAction.id;
    
    // Step 2: Configure the pre-execution validation function
    io:println("Step 2: Configuring pre-execution validation function...");
    
    // The payload for the function is a serverless function code or webhook URL
    string preExecutionFunctionPayload = "https://example.com/api/validate-workflow-action";
    
    actions:PublicActionFunctionIdentifier configuredFunction = check hubspotClient->/[appId]/[definitionId]/functions/["PRE_ACTION_EXECUTION"].put(preExecutionFunctionPayload);
    
    io:println("Successfully configured pre-execution validation function!");
    io:println("  - Function Type: " + configuredFunction.functionType);
    string functionId = configuredFunction.id ?: "N/A";
    io:println("  - Function ID: " + functionId);
    io:println();
    
    // Step 3: Verify the function was properly registered by listing all functions
    io:println("Step 3: Verifying registered functions for the action definition...");
    
    actions:CollectionResponsePublicActionFunctionIdentifierNoPaging functionsResponse = check hubspotClient->/[appId]/[definitionId]/functions();
    
    io:println("Functions associated with action definition '" + definitionId + "':");
    
    if functionsResponse.results.length() == 0 {
        io:println("  No functions registered yet.");
    } else {
        foreach actions:PublicActionFunctionIdentifier func in functionsResponse.results {
            string funcId = func.id ?: "N/A";
            io:println("  - Function Type: " + func.functionType + ", ID: " + funcId);
        }
    }
    io:println();
    
    // Summary
    io:println("=== Lifecycle Management Complete ===");
    io:println("Successfully completed the following operations:");
    io:println("  1. Created custom action definition with ID: " + definitionId);
    io:println("  2. Configured PRE_ACTION_EXECUTION validation function");
    io:println("  3. Verified " + functionsResponse.results.length().toString() + " function(s) registered");
    io:println();
    io:println("The custom workflow action is now ready for further configuration and publishing.");
}