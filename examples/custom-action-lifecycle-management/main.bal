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
    
    io:println("=== HubSpot Custom Automation Action Lifecycle Management ===\n");
    
    io:println("Step 1: Retrieving all custom action definitions for app ID: ", appId);
    io:println("------------------------------------------------------------------------");
    
    actions:CollectionResponsePublicActionDefinitionForwardPaging allActions = check hubspotClient->/[appId](archived = false, 'limit = 10);
    
    io:println("Total actions retrieved: ", allActions.results.length());
    
    if allActions.results.length() == 0 {
        io:println("No custom action definitions found for this app.");
        return;
    }
    
    foreach actions:PublicActionDefinition actionDef in allActions.results {
        io:println("\n  Action ID: ", actionDef.id);
        io:println("  Action URL: ", actionDef.actionUrl);
        io:println("  Published: ", actionDef.published);
        io:println("  Input Fields Count: ", actionDef.inputFields.length());
    }
    
    if allActions.paging is actions:ForwardPaging {
        actions:ForwardPaging paging = <actions:ForwardPaging>allActions.paging;
        if paging.next is actions:NextPage {
            actions:NextPage nextPage = <actions:NextPage>paging.next;
            io:println("\n  More results available. Next cursor: ", nextPage.after);
        }
    }
    
    io:println("\n\nStep 2: Fetching detailed information for a specific action");
    io:println("------------------------------------------------------------------------");
    
    string targetDefinitionId = allActions.results[0].id;
    io:println("Target Action Definition ID: ", targetDefinitionId);
    
    actions:PublicActionDefinition actionDetails = check hubspotClient->/[appId]/[targetDefinitionId](archived = false);
    
    io:println("\n  Detailed Action Information:");
    io:println("  -----------------------------");
    io:println("  ID: ", actionDetails.id);
    io:println("  Action URL: ", actionDetails.actionUrl);
    io:println("  Published: ", actionDetails.published);
    io:println("  Revision ID: ", actionDetails.revisionId);
    
    io:println("\n  Labels:");
    record {|actions:PublicActionLabels...;|} labels = actionDetails.labels;
    foreach [string, actions:PublicActionLabels] [langCode, labelInfo] in labels.entries() {
        io:println("    Language: ", langCode);
        io:println("      Action Name: ", labelInfo.actionName);
        if labelInfo.actionDescription is string {
            io:println("      Description: ", labelInfo.actionDescription);
        }
    }
    
    io:println("\n  Input Fields:");
    foreach actions:InputFieldDefinition inputField in actionDetails.inputFields {
        io:println("    - Field Name: ", inputField.typeDefinition.name);
        io:println("      Required: ", inputField.isRequired);
        if inputField.typeDefinition.description is string {
            io:println("      Description: ", inputField.typeDefinition.description);
        }
    }
    
    io:println("\n  Associated Functions:");
    foreach actions:PublicActionFunctionIdentifier funcId in actionDetails.functions {
        io:println("    - Function Type: ", funcId.functionType);
        if funcId.id is string {
            io:println("      Function ID: ", funcId.id);
        }
    }
    
    io:println("\n\nStep 3: Updating action definition with improved settings");
    io:println("------------------------------------------------------------------------");
    
    actions:PublicActionLabels updatedEnglishLabels = {
        actionName: "Enhanced Custom Action",
        actionDescription: "This action has been updated with improved settings for better automation workflow behavior.",
        actionCardContent: "Execute enhanced custom automation action"
    };
    
    actions:PublicActionDefinitionPatch patchPayload = {
        labels: {
            "en": updatedEnglishLabels
        },
        published: actionDetails.published
    };
    
    io:println("Applying updates to action definition...");
    io:println("  - Updated action name: Enhanced Custom Action");
    io:println("  - Updated description with improved workflow behavior details");
    
    actions:PublicActionDefinition updatedAction = check hubspotClient->/[appId]/[targetDefinitionId].patch(patchPayload);
    
    io:println("\n  Action Updated Successfully!");
    io:println("  ----------------------------");
    io:println("  Updated Action ID: ", updatedAction.id);
    io:println("  New Revision ID: ", updatedAction.revisionId);
    io:println("  Action URL: ", updatedAction.actionUrl);
    io:println("  Published Status: ", updatedAction.published);
    
    io:println("\n  Updated Labels:");
    record {|actions:PublicActionLabels...;|} updatedLabels = updatedAction.labels;
    foreach [string, actions:PublicActionLabels] [langCode, labelInfo] in updatedLabels.entries() {
        io:println("    Language: ", langCode);
        io:println("      Action Name: ", labelInfo.actionName);
        if labelInfo.actionDescription is string {
            io:println("      Description: ", labelInfo.actionDescription);
        }
        if labelInfo.actionCardContent is string {
            io:println("      Card Content: ", labelInfo.actionCardContent);
        }
    }
    
    io:println("\n=== Custom Automation Action Lifecycle Management Complete ===");
    io:println("\nSummary:");
    io:println("  1. Retrieved ", allActions.results.length(), " action definition(s) for app");
    io:println("  2. Fetched detailed configuration for action: ", targetDefinitionId);
    io:println("  3. Successfully updated action with improved labels and descriptions");
}