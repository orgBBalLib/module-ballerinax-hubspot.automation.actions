# Automation Action Version Rollback

This example demonstrates how to create a custom HubSpot automation action and manage its revision history for version tracking and rollback analysis. The script creates an ML-based lead scoring action, retrieves its revision history, and performs a configuration comparison to determine if a rollback is needed.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/ballerina/Package.md) to obtain your access token and app ID.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   appId = <Your App ID>
   ```

   > **Note:** The `appId` should be an integer value without quotes.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the action creation, revision history retrieval, and rollback analysis results.

```shell
bal run
```