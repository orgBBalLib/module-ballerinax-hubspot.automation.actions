import ballerina/io;
import ballerinax/hubspot.automation.actions;

configurable string accessToken = ?;

configurable int:Signed32 appId = ?;
configurable string definitionId = ?;

public function main() returns error? {
    actions:ConnectionConfig config = {
        auth: {
            token: accessToken
        }
    };
    
    actions:Client hubspotClient = check new (config);
    
    io:println("=== HubSpot Workflow Action Version Control and Rollback System ===\n");
    
    io:println("Step 1: Retrieving revision history for action definition...");
    io:println("App ID: ", appId);
    io:println("Definition ID: ", definitionId);
    
    actions:CollectionResponsePublicActionRevisionForwardPaging revisionsResponse = check hubspotClient->/[appId]/[definitionId]/revisions('limit = 10);
    
    io:println("\nRevision History Retrieved Successfully!");
    io:println("Total revisions found: ", revisionsResponse.results.length());
    
    io:println("\n--- Revision History Audit ---");
    foreach actions:PublicActionRevision revision in revisionsResponse.results {
        io:println("Revision ID: ", revision.revisionId);
        io:println("  Created At: ", revision.createdAt);
        io:println("  Action URL: ", revision.definition.actionUrl);
        io:println("  Published: ", revision.definition.published);
        io:println("  Input Fields Count: ", revision.definition.inputFields.length());
        io:println("");
    }
    
    if revisionsResponse.paging is actions:ForwardPaging {
        actions:ForwardPaging paging = <actions:ForwardPaging>revisionsResponse.paging;
        if paging.next is actions:NextPage {
            actions:NextPage nextPage = <actions:NextPage>paging.next;
            io:println("More revisions available. Next page cursor: ", nextPage.after);
        }
    }
    
    io:println("\n--- Step 2: Fetching Specific Revision Details ---");
    
    if revisionsResponse.results.length() > 0 {
        actions:PublicActionRevision latestRevision = revisionsResponse.results[0];
        string targetRevisionId = latestRevision.revisionId;
        
        io:println("Fetching details for revision: ", targetRevisionId);
        
        actions:PublicActionRevision revisionDetails = check hubspotClient->/[appId]/[definitionId]/revisions/[targetRevisionId]();
        
        io:println("\nRevision Details Retrieved:");
        io:println("  Revision ID: ", revisionDetails.revisionId);
        io:println("  ID: ", revisionDetails.id);
        io:println("  Created At: ", revisionDetails.createdAt);
        io:println("\n  Definition Details:");
        io:println("    Action URL: ", revisionDetails.definition.actionUrl);
        io:println("    Published: ", revisionDetails.definition.published);
        io:println("    Functions Count: ", revisionDetails.definition.functions.length());
        
        io:println("\n  Input Fields:");
        foreach actions:InputFieldDefinition inputField in revisionDetails.definition.inputFields {
            io:println("    - Name: ", inputField.typeDefinition.name);
            io:println("      Required: ", inputField.isRequired);
            ("STATIC_VALUE"|"OBJECT_PROPERTY"|"FIELD_DATA"|"FETCHED_OBJECT_PROPERTY"|"ENROLLMENT_EVENT_PROPERTY")[]? rawSupportedTypes = inputField.supportedValueTypes;
            if rawSupportedTypes is ("STATIC_VALUE"|"OBJECT_PROPERTY"|"FIELD_DATA"|"FETCHED_OBJECT_PROPERTY"|"ENROLLMENT_EVENT_PROPERTY")[] {
                io:println("      Supported Value Types: ", rawSupportedTypes.toString());
            }
        }
        
        io:println("\n  Labels:");
        record {|actions:PublicActionLabels...;|} definitionLabelsRecord = revisionDetails.definition.labels;
        string? actionNameValue = <string?>definitionLabelsRecord["actionName"];
        if actionNameValue is string {
            io:println("    Action Name: ", actionNameValue);
        }
        string? actionDescValue = <string?>definitionLabelsRecord["actionDescription"];
        if actionDescValue is string {
            io:println("    Description: ", actionDescValue);
        }
        
        io:println("\n--- Step 3: Rolling Back to Previous Known-Good State ---");
        
        if revisionsResponse.results.length() > 1 {
            actions:PublicActionRevision previousRevision = revisionsResponse.results[1];
            string previousRevisionId = previousRevision.revisionId;
            
            io:println("Detected problematic configuration in current version.");
            io:println("Rolling back to previous revision: ", previousRevisionId);
            
            actions:PublicActionRevision previousRevisionDetails = check hubspotClient->/[appId]/[definitionId]/revisions/[previousRevisionId]();
            
            actions:PublicActionDefinitionPatch rollbackPatch = {
                actionUrl: previousRevisionDetails.definition.actionUrl,
                inputFields: previousRevisionDetails.definition.inputFields
            };
            
            io:println("\nApplying rollback patch...");
            io:println("  Restoring Action URL: ", rollbackPatch.actionUrl);
            actions:InputFieldDefinition[]? rollbackInputFields = rollbackPatch.inputFields;
            int inputFieldsCount = 0;
            if rollbackInputFields is actions:InputFieldDefinition[] {
                inputFieldsCount = rollbackInputFields.length();
            }
            io:println("  Restoring Input Fields Count: ", inputFieldsCount);
            
            actions:PublicActionDefinition updatedDefinition = check hubspotClient->/[appId]/[definitionId].patch(rollbackPatch);
            
            io:println("\n=== Rollback Completed Successfully! ===");
            io:println("Updated Definition Details:");
            io:println("  Action URL: ", updatedDefinition.actionUrl);
            io:println("  Published: ", updatedDefinition.published);
            io:println("  Input Fields Count: ", updatedDefinition.inputFields.length());
            io:println("  Functions Count: ", updatedDefinition.functions.length());
            
            io:println("\nRestored Input Fields:");
            foreach actions:InputFieldDefinition restoredField in updatedDefinition.inputFields {
                io:println("  - ", restoredField.typeDefinition.name, " (Required: ", restoredField.isRequired, ")");
            }
            
        } else {
            io:println("No previous revision available for rollback.");
            io:println("This is the initial version of the action definition.");
        }
        
    } else {
        io:println("No revisions found for the specified action definition.");
        io:println("Please ensure the appId and definitionId are correct.");
    }
    
    io:println("\n=== Version Control and Rollback Process Complete ===");
}