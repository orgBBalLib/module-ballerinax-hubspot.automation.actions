# Custom Action Lifecycle Management

This example demonstrates how to manage the complete lifecycle of custom automation actions in HubSpot. The script retrieves all custom action definitions for a specified app, fetches detailed information about a specific action, and updates the action's labels and descriptions.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/blob/main/ballerina/Package.md#setup-guide) to obtain your access token and app ID.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   accessToken = "<Your Access Token>"
   appId = <Your App ID>
   ```

   > **Note:** The `appId` should be an integer value without quotes.

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the retrieval, inspection, and update operations on your custom automation actions.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot Custom Automation Action Lifecycle Management ===

Step 1: Retrieving all custom action definitions for app ID: <appId>
------------------------------------------------------------------------
Total actions retrieved: <count>

Step 2: Fetching detailed information for a specific action
------------------------------------------------------------------------
...

Step 3: Updating action definition with improved settings
------------------------------------------------------------------------
...

=== Custom Automation Action Lifecycle Management Complete ===
```