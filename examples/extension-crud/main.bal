// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/http;

configurable string apiKey = ?;

type FieldTypeDefinition record {
    string referencedObjectType;
    boolean externalOptions;
    string externalOptionsReferenceType;
    string name;
    string 'type;
    string fieldType;
    string optionsUrl;
    anydata[] options;
};

type InputFieldDefinition record {
    boolean isRequired;
    string automationFieldType;
    FieldTypeDefinition typeDefinition;
    string[] supportedValueTypes;
};

type PublicActionFunction record {
    string functionSource;
    string functionType;
};

type LabelDefinition record {
    map<string> inputFieldLabels;
    string actionName;
    string actionDescription;
    string appDisplayName;
    string actionCardContent;
};

type PublicActionDefinitionEgg record {
    InputFieldDefinition[] inputFields;
    string actionUrl;
    boolean published;
    string[] objectTypes;
    record {string[] properties;} objectRequestOptions;
    PublicActionFunction[] functions;
    map<LabelDefinition> labels;
};

type PublicActionDefinition record {
    string id;
    InputFieldDefinition[] inputFields?;
    string actionUrl?;
    boolean published?;
    string[] objectTypes?;
};

public function main() returns error? {

    // Client initialization with API key
    http:Client hubspotAutomation = check new ("https://api.hubapi.com/automation/v4/actions", {
        auth: {
            token: apiKey
        }
    });

    // sample extension definition
    string createdExtensionId = "";
    int appId = 5712614;

    FieldTypeDefinition typeDefinition = {
        referencedObjectType: "OWNER",
        externalOptions: false,
        externalOptionsReferenceType: "",
        name: "optionsInput",
        'type: "enumeration",
        fieldType: "select",
        optionsUrl: "https://webhook.site/94d09471-6f4c-4a7f-bae2-c9a585dd41e0",
        options: []
    };

    InputFieldDefinition inputFieldDefinition = {
        isRequired: true,
        automationFieldType: "",
        typeDefinition: typeDefinition,
        supportedValueTypes: ["STATIC_VALUE"]
    };

    PublicActionFunction publicActionFunction = {
        functionSource: "exports.main = (event, callback) => {\r\n  callback({\r\n    outputFields: {\r\n      myOutput: \"example output value\"\r\n    }\r\n  });\r\n}",
        functionType: "POST_ACTION_EXECUTION"
    };

    PublicActionDefinitionEgg testingPublicActionDefinitionEgg = {
        inputFields: [inputFieldDefinition],
        actionUrl: "https://webhook.site/94d09471-6f4c-4a7f-bae2-c9a585dd41e0",
        published: false,
        objectTypes: ["CONTACT"],
        objectRequestOptions: {properties: ["email"]},
        functions: [publicActionFunction],
        labels: {
            "en": {
                inputFieldLabels: {
                    "staticInput": "Static Input",
                    "objectInput": "Object Property Input",
                    "optionsInput": "External Options Input"
                },
                actionName: "My Extension",
                actionDescription: "My Extension Description",
                appDisplayName: "My App Display Name",
                actionCardContent: "My Action Card Content"
            }
        }
    };

    // Create Extension
    http:Response createHttpResponse = check hubspotAutomation->post(string `/${appId}`, testingPublicActionDefinitionEgg);
    json createResponseJson = check createHttpResponse.getJsonPayload();
    PublicActionDefinition createResponse = check createResponseJson.cloneWithType();
    createdExtensionId = createResponse.id;
    io:println("Extension Created with ID: " + createdExtensionId);

    // Get Extension
    http:Response getHttpResponse = check hubspotAutomation->get(string `/${appId}/${createdExtensionId}`);
    json getResponseJson = check getHttpResponse.getJsonPayload();
    PublicActionDefinition getResponse = check getResponseJson.cloneWithType();
    io:println("Extension Retrieved: " + getResponse.id);

    // Update Extension
    http:Response updateHttpResponse = check hubspotAutomation->patch(string `/${appId}/${createdExtensionId}`, testingPublicActionDefinitionEgg);
    json updateResponseJson = check updateHttpResponse.getJsonPayload();
    PublicActionDefinition updateResponse = check updateResponseJson.cloneWithType();
    io:println("Extension Updated: ");
    io:println(updateResponse);

    // Delete Extension
    http:Response _ = check hubspotAutomation->delete(string `/${appId}/${createdExtensionId}`);
    io:println("Extension Deleted");
}