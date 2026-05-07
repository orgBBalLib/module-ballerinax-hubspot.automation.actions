# Examples

The `hubspot.automation.actions` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples), covering use cases like automation action version rollback, and custom action lifecycle management.

1. [Automation action version rollback](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/automation-action-version-rollback) - Rollback an automation action to a previous version when issues are detected.

2. [Custom action lifecycle management](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/custom-action-lifecycle-management) - Manage the complete lifecycle of custom automation actions including creation, updates, and deletion.

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