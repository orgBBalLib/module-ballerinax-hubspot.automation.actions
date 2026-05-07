# Examples

The `hubspot.automation.actions` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples), covering use cases like action version rollback, and workflow action lifecycle management.

1. [Action version rollback](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/action-version-rollback) - Rollback a custom workflow action to a previous version in HubSpot.

2. [Workflow action lifecycle management](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/workflow-action-lifecycle-management) - Manage the complete lifecycle of custom workflow actions including creation, updates, and deletion.

## Prerequisites

1. Generate HubSpot credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/hubspot.automation.actions/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    token = "<Access Token>"
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```