# Callback Completion

This example demonstrates how to complete callback requests in HubSpot automation workflows by sending batch completion requests with output fields to the HubSpot Automation Actions API.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/ballerina/Package.md) to obtain your OAuth credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   oauthKey = "<Your OAuth Token>"
   ```

## Run the Example

Execute the following command to run the example. The script will send a batch callback completion request to HubSpot and print a success message to the console.

```shell
bal run
```