## Overview

[HubSpot](https://www.hubspot.com/) is a cloud-based customer relationship management (CRM) platform that provides marketing, sales, customer service, and content management tools to help businesses grow and manage customer relationships effectively.

The `ballerinax/hubspot.automation.actions` package offers APIs to connect and interact with [HubSpot Automation Actions API](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions) endpoints, specifically based on [HubSpot Automation Actions API v4](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions).
## Setup guide

To use the HubSpot Automation Actions connector, you must have access to the HubSpot API through a [HubSpot developer account](https://developers.hubspot.com/) and obtain an API access token. If you do not have a HubSpot account, you can sign up for one [here](https://app.hubspot.com/signup-hubspot/crm).

### Step 1: Create a HubSpot Account

1. Navigate to the [HubSpot website](https://www.hubspot.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a Professional or Enterprise plan, as the Automation Actions API requires access to workflows which are restricted to users on these plans.

### Step 2: Generate an API Access Token

1. Log in to your HubSpot account.

2. In the main navigation bar, click the Settings icon (gear icon) in the top right corner.

3. In the left sidebar menu, navigate to Integrations, then select Private Apps.

4. Click Create a private app.

5. On the Basic Info tab, enter a name and description for your app.

6. Navigate to the Scopes tab and select the required scopes for automation actions (such as `automation` under the CRM section).

7. Click Create app in the top right corner, then review the information and click Continue creating.

8. Copy the generated access token that is displayed.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again in your account settings for security reasons.
## Quickstart

To use the `HubSpot Automation Actions` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/hubspot.automation.actions as hsactions;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and configure the obtained credentials:

```toml
clientId = "<Your_Client_Id>"
clientSecret = "<Your_Client_Secret>"
refreshToken = "<Your_Refresh_Token>"
```

2. Create a `hsactions:ConnectionConfig` and initialize the client:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;

final hsactions:Client hsActionsClient = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshToken
    }
});
```

### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Create a new custom action definition

```ballerina
public function main() returns error? {
    hsactions:PublicActionDefinitionEgg newAction = {
        actionUrl: "https://example.com/webhook/action",
        published: false,
        objectTypes: ["CONTACT"],
        labels: {
            "en": {
                actionName: "Send Welcome Email",
                actionDescription: "Sends a welcome email to the contact"
            }
        },
        inputFields: [
            {
                isRequired: true,
                typeDefinition: {
                    name: "email",
                    label: "Email Address",
                    'type: "string",
                    fieldType: "text",
                    options: [],
                    useChirp: false,
                    externalOptions: false
                }
            }
        ],
        functions: []
    };

    hsactions:PublicActionDefinition response = check hsActionsClient->/[12345].post(newAction);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `hubspot.automation.actions` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples), covering the following use cases:

1. [Callback completion](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/callback-completion) - Demonstrates how to complete automation action callbacks using the HubSpot connector.
2. [Extension crud](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/extension-crud) - Illustrates creating, retrieving, updating, and deleting automation action extensions.