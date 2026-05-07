# Action Version Rollback

This example demonstrates how to implement a version control and rollback system for HubSpot workflow actions. The script retrieves the revision history for an action definition, fetches specific revision details, and performs a rollback to a previous known-good state when issues are detected.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/ballerina/Package.md) to obtain your access token and configure the automation actions API.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with the following configuration:

   ```toml
   accessToken = "<Your Access Token>"
   appId = <Your App ID>
   definitionId = "<Your Definition ID>"
   ```

   | Configuration   | Description                                                    |
   |-----------------|----------------------------------------------------------------|
   | `accessToken`   | The OAuth access token for authenticating with HubSpot API    |
   | `appId`         | The numeric ID of your HubSpot app                             |
   | `definitionId`  | The unique identifier of the action definition to manage       |

## Run the Example

Execute the following command to run the example. The script will print its progress to the console, showing the revision history retrieval, revision details, and rollback process.

```bash
bal run
```

Upon successful execution, you will see output similar to:

```
=== HubSpot Workflow Action Version Control and Rollback System ===

Step 1: Retrieving revision history for action definition...
App ID: 12345
Definition ID: abc-123-def

Revision History Retrieved Successfully!
Total revisions found: 3

--- Revision History Audit ---
Revision ID: rev-001
  Created At: 2024-01-15T10:30:00Z
  Action URL: https://example.com/webhook
  Published: true
  Input Fields Count: 2
...

=== Version Control and Rollback Process Complete ===
```