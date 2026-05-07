
# Ballerina hubspot.automation.actions connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-hubspot.automation.actions.svg)](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/hubspot.automation.actions.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%hubspot.automation.actions)

## Overview

[HubSpot](https://www.hubspot.com/) is a cloud-based customer relationship management (CRM) platform that provides marketing, sales, content management, and customer service tools to help businesses grow and manage customer relationships effectively.

The `ballerinax/hubspot.automation.actions` package offers APIs to connect and interact with [HubSpot Automation Actions API](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions) endpoints, specifically based on [HubSpot Automation Actions API v4](https://developers.hubspot.com/docs/api/automation/custom-workflow-actions).
## Setup guide

To use the HubSpot Automation Actions connector, you must have access to the HubSpot API through a [HubSpot developer account](https://developers.hubspot.com/) and obtain an API access token. If you do not have a HubSpot account, you can sign up for one [here](https://app.hubspot.com/signup-hubspot/crm).

### Step 1: Create a HubSpot Account

1. Navigate to the [HubSpot website](https://www.hubspot.com/) and sign up for an account or log in if you already have one.

2. Note that access to automation actions via the API requires a Professional or Enterprise plan subscription, as workflow automation features are restricted to users on these plans.

### Step 2: Generate an API Access Token

1. Log in to your HubSpot account.

2. Click the settings icon (gear) in the main navigation bar.

3. In the left sidebar menu, navigate to Integrations, then select Private Apps.

4. Click Create a private app.

5. On the Basic Info tab, enter a name and description for your app.

6. Navigate to the Scopes tab and select the required scopes for automation actions (such as `automation` under the CRM section).

7. Click Create app in the top right corner, then click Continue creating to confirm.

8. In the dialog box, review the access token and click Copy to copy it to your clipboard.

> **Tip:** You must copy and store this key somewhere safe. It won't be visible again after you navigate away from this page for security reasons.
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

final hsactions:Client hsactionsClient = check new({
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
        actionUrl: "https://example.com/webhook",
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
                    options: []
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

1. [Callback completion](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/callback-completion) - Demonstrates how to complete asynchronous action callbacks in HubSpot automation workflows.
2. [Extension crud](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/extension-crud) - Illustrates creating, retrieving, updating, and deleting automation action extensions.
## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

    > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

    > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

    ```bash
    ./gradlew clean build
    ```

2. To run the tests:

    ```bash
    ./gradlew clean test
    ```

3. To build the without the tests:

    ```bash
    ./gradlew clean build -x test
    ```

4. To run tests against different environments:

    ```bash
    ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
    ```

5. To debug the package with a remote debugger:

    ```bash
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with the Ballerina language:

    ```bash
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).


## Useful links

* For more information go to the [`hubspot.automation.actions` package](https://central.ballerina.io/ballerinax/hubspot.automation.actions/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
