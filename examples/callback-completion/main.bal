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

configurable string oauthKey = ?;

type CallbackCompletionRequest record {
    string callbackId;
    map<string> outputFields;
};

type BatchInputCallbackCompletionBatchRequest record {
    CallbackCompletionRequest[] inputs;
};

public function main() returns error? {
    http:Client automationClient = check new ("https://api.hubapi.com/automation/v4/actions", {
        auth: {
            token: oauthKey
        }
    });

    BatchInputCallbackCompletionBatchRequest batchCallbackCompletionRequest = {
        inputs: [
            {
                callbackId: "1",
                outputFields: {
                    "exampleField": "exampleValue"
                }
            }
        ]
    };
    http:Response _ = check automationClient->/callbacks/complete.post(batchCallbackCompletionRequest);
    io:println("Batch completion request sent successfully");
}