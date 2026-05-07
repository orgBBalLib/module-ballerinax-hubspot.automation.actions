# Callback Completion

This example demonstrates how to complete callback actions in HubSpot's automation workflows by sending batch completion requests with output fields to the HubSpot Automation API.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/blob/main/ballerina/Package.md#setup-guide) to obtain your OAuth credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   oauthKey = "<Your OAuth Access Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will send a batch callback completion request to HubSpot and print the response status to the console.

```shell
bal run
```