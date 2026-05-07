import ballerina/io;
import ballerinax/hubspot.automation.actions;

configurable string accessToken = ?;

configurable int:Signed32 appId = ?;

public function main() returns error? {
    actions:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    actions:Client hubspotClient = check new (config);
    
    io:println("=== HubSpot Automation Action Versioning and Rollback System ===\n");
    
    io:println("Step 1: Creating a new custom automation action for ML-based lead scoring...\n");
    
    actions:PublicActionDefinitionEgg leadScoringActionPayload = {
        actionUrl: "https://ml-service.example.com/api/v1/lead-scoring",
        objectTypes: ["CONTACT"],
        published: false,
        inputFields: [
            {
                isRequired: true,
                typeDefinition: {
                    name: "contactEmail",
                    options: [],
                    externalOptions: false,
                    'type: "string"
                },
                supportedValueTypes: [<"STATIC_VALUE"|"OBJECT_PROPERTY">"OBJECT_PROPERTY", <"STATIC_VALUE"|"OBJECT_PROPERTY">"STATIC_VALUE"]
            },
            {
                isRequired: true,
                typeDefinition: {
                    name: "companyName",
                    options: [],
                    externalOptions: false,
                    'type: "string"
                },
                supportedValueTypes: [<"STATIC_VALUE"|"OBJECT_PROPERTY">"OBJECT_PROPERTY", <"STATIC_VALUE"|"OBJECT_PROPERTY">"STATIC_VALUE"]
            },
            {
                isRequired: false,
                typeDefinition: {
                    name: "engagementScore",
                    options: [],
                    externalOptions: false,
                    'type: "number"
                },
                supportedValueTypes: [<"STATIC_VALUE"|"OBJECT_PROPERTY">"OBJECT_PROPERTY", <"STATIC_VALUE"|"OBJECT_PROPERTY">"STATIC_VALUE"]
            },
            {
                isRequired: false,
                typeDefinition: {
                    name: "industry",
                    options: [
                        {
                            label: "Technology",
                            value: "technology",
                            displayOrder: 1,
                            hidden: false,
                            description: "Technology industry vertical",
                            doubleData: 0.0,
                            readOnly: false
                        },
                        {
                            label: "Healthcare",
                            value: "healthcare",
                            displayOrder: 2,
                            hidden: false,
                            description: "Healthcare industry vertical",
                            doubleData: 0.0,
                            readOnly: false
                        },
                        {
                            label: "Finance",
                            value: "finance",
                            displayOrder: 3,
                            hidden: false,
                            description: "Finance industry vertical",
                            doubleData: 0.0,
                            readOnly: false
                        },
                        {
                            label: "Retail",
                            value: "retail",
                            displayOrder: 4,
                            hidden: false,
                            description: "Retail industry vertical",
                            doubleData: 0.0,
                            readOnly: false
                        }
                    ],
                    externalOptions: false,
                    'type: "enumeration"
                },
                supportedValueTypes: [<"STATIC_VALUE"|"OBJECT_PROPERTY">"STATIC_VALUE", <"STATIC_VALUE"|"OBJECT_PROPERTY">"OBJECT_PROPERTY"]
            }
        ],
        functions: [
            {
                functionType: "PRE_ACTION_EXECUTION",
                functionSource: "exports.main = (event, callback) => { callback({ outputFields: { leadScore: 0, leadTier: 'pending' } }); }"
            },
            {
                functionType: "POST_ACTION_EXECUTION",
                functionSource: "exports.main = (event, callback) => { const score = event.fields.leadScore; const tier = score >= 80 ? 'hot' : score >= 50 ? 'warm' : 'cold'; callback({ outputFields: { leadScore: score, leadTier: tier } }); }"
            }
        ],
        labels: {
            "en": {
                actionName: "ML Lead Scoring Action",
                actionDescription: "Integrates with external ML service to calculate lead scores based on contact and engagement data",
                actionCardContent: "Score leads using AI/ML predictions",
                inputFieldLabels: {
                    "contactEmail": "Contact Email Address",
                    "companyName": "Company Name",
                    "engagementScore": "Current Engagement Score",
                    "industry": "Industry Vertical"
                },
                inputFieldDescriptions: {
                    "contactEmail": "The email address of the contact to score",
                    "companyName": "The company associated with the lead",
                    "engagementScore": "Optional pre-existing engagement score",
                    "industry": "The industry vertical for the lead"
                },
                outputFieldLabels: {
                    "leadScore": "Predicted Lead Score",
                    "leadTier": "Lead Quality Tier"
                }
            }
        }
    };
    
    actions:PublicActionDefinition createdAction = check hubspotClient->/[appId].post(leadScoringActionPayload);
    
    io:println("Successfully created custom automation action!");
    io:println("Action ID: " + createdAction.id);
    io:println("Action Name: " + createdAction.labels.get("en").actionName);
    io:println("Action URL: " + createdAction.actionUrl);
    io:println("Published Status: " + createdAction.published.toString());
    io:println("Revision ID: " + createdAction.revisionId);
    io:println("");
    
    string definitionId = createdAction.id;
    
    io:println("Step 2: Retrieving revision history for change tracking...\n");
    
    actions:CollectionResponsePublicActionRevisionForwardPaging revisionsResponse = check hubspotClient->/[appId]/[definitionId]/revisions.get('limit = 10);
    
    io:println("Found " + revisionsResponse.results.length().toString() + " revision(s) for the action:\n");
    
    string? targetRevisionId = ();
    
    foreach int i in 0 ..< revisionsResponse.results.length() {
        actions:PublicActionRevision revision = revisionsResponse.results[i];
        io:println("Revision #" + (i + 1).toString());
        io:println("  Revision ID: " + revision.revisionId);
        io:println("  Created At: " + revision.createdAt);
        io:println("  Definition ID: " + revision.definition.id);
        io:println("  Action URL: " + revision.definition.actionUrl);
        io:println("  Input Fields Count: " + revision.definition.inputFields.length().toString());
        io:println("");
        
        if i == 0 {
            targetRevisionId = revision.revisionId;
        }
    }
    
    if revisionsResponse.paging is actions:ForwardPaging {
        actions:ForwardPaging paging = <actions:ForwardPaging>revisionsResponse.paging;
        if paging.next is actions:NextPage {
            actions:NextPage nextPage = <actions:NextPage>paging.next;
            io:println("More revisions available. Next page cursor: " + nextPage.after);
            io:println("");
        }
    }
    
    io:println("Step 3: Fetching specific revision for configuration comparison...\n");
    
    if targetRevisionId is string {
        actions:PublicActionRevision specificRevision = check hubspotClient->/[appId]/[definitionId]/revisions/[targetRevisionId].get();
        
        io:println("Retrieved Specific Revision Details:");
        io:println("=====================================");
        io:println("Revision ID: " + specificRevision.revisionId);
        io:println("Created At: " + specificRevision.createdAt);
        io:println("Action ID: " + specificRevision.id);
        io:println("");
        
        io:println("Revision Definition Configuration:");
        io:println("----------------------------------");
        io:println("Action URL: " + specificRevision.definition.actionUrl);
        io:println("Published: " + specificRevision.definition.published.toString());
        io:println("");
        
        io:println("Input Fields in this Revision:");
        actions:InputFieldDefinition[] inputFieldsList = specificRevision.definition.inputFields;
        foreach actions:InputFieldDefinition inputField in inputFieldsList {
            actions:FieldTypeDefinition fieldTypeDef = inputField.typeDefinition;
            io:println("  - Field: " + fieldTypeDef.name);
            io:println("    Required: " + inputField.isRequired.toString());
            anydata rawSupportedTypes = inputField.supportedValueTypes;
            if rawSupportedTypes is anydata[] {
                io:println("    Supported Value Types: " + rawSupportedTypes.toString());
            }
        }
        io:println("");
        
        io:println("Functions in this Revision:");
        foreach actions:PublicActionFunctionIdentifier functionId in specificRevision.definition.functions {
            io:println("  - Function Type: " + functionId.functionType);
            string? funcId = functionId.id;
            if funcId is string {
                io:println("    Function ID: " + funcId);
            }
        }
        io:println("");
        
        io:println("=== Rollback Analysis Summary ===");
        io:println("Current Action Configuration vs Revision " + specificRevision.revisionId + ":");
        io:println("");
        io:println("Current Action URL: " + createdAction.actionUrl);
        io:println("Revision Action URL: " + specificRevision.definition.actionUrl);
        io:println("");
        io:println("Current Input Fields: " + createdAction.inputFields.length().toString());
        io:println("Revision Input Fields: " + specificRevision.definition.inputFields.length().toString());
        io:println("");
        io:println("Current Functions: " + createdAction.functions.length().toString());
        io:println("Revision Functions: " + specificRevision.definition.functions.length().toString());
        io:println("");
        
        boolean urlsMatch = createdAction.actionUrl == specificRevision.definition.actionUrl;
        boolean fieldsMatch = createdAction.inputFields.length() == specificRevision.definition.inputFields.length();
        boolean configsMatch = urlsMatch && fieldsMatch;
        
        if configsMatch {
            io:println("Status: Configurations are identical. No rollback needed.");
        } else {
            io:println("Status: Configuration differences detected. Review before rollback.");
            io:println("Recommendation: Consider reverting to revision " + specificRevision.revisionId + " if current version has issues.");
        }
        io:println("");
        
        io:println("=== Change Management Compliance ===");
        io:println("Revision tracking enabled: Yes");
        io:println("Total revisions tracked: " + revisionsResponse.results.length().toString());
        io:println("Latest stable revision: " + specificRevision.revisionId);
        io:println("Audit trail available: Yes");
        io:println("");
        
    } else {
        io:println("No revision ID available for detailed comparison.");
    }
    
    io:println("=== Versioning and Rollback System Demo Complete ===");
}