# Examples

The `hubspot.automation.actions` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples), covering use cases like callback completion, and extension CRUD operations.

1. [Callback completion](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/callback-completion) - Demonstrate how to complete a callback for an automation action in HubSpot workflows.

2. [Extension CRUD](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/examples/extension-crud) - Perform create, read, update, and delete operations on automation action extensions in HubSpot.

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