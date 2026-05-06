## Overview

[HubSpot](https://www.hubspot.com/) is a cloud-based customer relationship management (CRM) platform that provides software solutions for marketing, sales, customer service, and content management, helping businesses attract, engage, and delight customers at scale.

The `ballerinax/hubspot.automation.actions` package offers APIs to connect and interact with [HubSpot Automation Actions API](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions) endpoints, specifically based on [HubSpot Automation Actions API v4](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions).
## Setup guide

To use the HubSpot Automation Actions connector, you must have access to the HubSpot API through a [HubSpot developer account](https://developers.hubspot.com/) and obtain an API access token. If you do not have a HubSpot account, you can sign up for one [here](https://app.hubspot.com/signup-hubspot/crm).

### Step 1: Create a HubSpot Account

1. Navigate to the [HubSpot website](https://www.hubspot.com/) and sign up for an account or log in if you already have one.

2. Ensure you have a Professional or Enterprise plan subscription, as the Automation Actions API requires access to workflows which are only available on these plans.

### Step 2: Generate an API Access Token

1. Log in to your HubSpot account.

2. In the main navigation bar, click the settings icon (gear icon) to access your account settings.

3. In the left sidebar menu, navigate to Integrations > Private Apps.

4. Click Create a private app.

5. On the Basic Info tab, provide a name and description for your app.

6. Navigate to the Scopes tab and select the required scopes for automation actions (such as `automation` and any other relevant scopes your integration needs).

7. Click Create app in the top right corner, then click Continue creating to confirm.

8. Once the app is created, you will see your access token displayed. Click Show token to reveal it.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again without clicking "Show token" and for security reasons, you should treat it like a password.
## Quickstart

To use the `HubSpot Automation Actions` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/oauth2;
import ballerinax/hubspot.automation.actions as hsactions;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file with your credentials:

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

final hsactions:Client hsactionsClient = check new ({
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
        functions: [],
        inputFields: [
            {
                isRequired: true,
                typeDefinition: {
                    name: "email",
                    label: "Contact Email",
                    'type: "string",
                    fieldType: "text",
                    options: [],
                    externalOptions: false,
                    useChirp: false
                }
            }
        ],
        labels: {
            "en": {
                actionName: "Send Welcome Email",
                actionDescription: "Sends a welcome email to new contacts"
            }
        }
    };

    hsactions:PublicActionDefinition response = check hsactionsClient->/[12345].post(newAction);
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```
## Examples

The `hubspot.automation.actions` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples), covering the following use cases:

1. [Callback completion](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/callback-completion) - Demonstrates how to complete asynchronous automation action callbacks using the HubSpot connector.
2. [Extension crud](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/extension-crud) - Illustrates creating, retrieving, updating, and deleting automation action extensions.