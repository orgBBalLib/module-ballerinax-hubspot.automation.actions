# Workflow Action Lifecycle Management

This example demonstrates how to manage the complete lifecycle of a custom workflow action in HubSpot, including creating a custom action definition with input fields, configuring a pre-execution validation function, and verifying the registered functions.

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

Execute the following command to run the example. The script will print its progress to the console, showing each step of the workflow action lifecycle management process.

```shell
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot Workflow Action Lifecycle Management ===

Step 1: Creating a new custom action definition...
Successfully created action definition!
  - Action ID: <generated-id>
  - Action URL: https://example.com/api/workflow-action
  - Published: false
  - Number of input fields: 3

Step 2: Configuring pre-execution validation function...
Successfully configured pre-execution validation function!
  - Function Type: PRE_ACTION_EXECUTION
  - Function ID: <function-id>

Step 3: Verifying registered functions for the action definition...
Functions associated with action definition '<definition-id>':
  - Function Type: PRE_ACTION_EXECUTION, ID: <function-id>

=== Lifecycle Management Complete ===
Successfully completed the following operations:
  1. Created custom action definition with ID: <definition-id>
  2. Configured PRE_ACTION_EXECUTION validation function
  3. Verified 1 function(s) registered

The custom workflow action is now ready for further configuration and publishing.
```