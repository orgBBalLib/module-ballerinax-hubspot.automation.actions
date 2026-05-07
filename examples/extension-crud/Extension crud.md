# Extension CRUD

This example demonstrates how to perform complete CRUD (Create, Read, Update, Delete) operations on HubSpot automation action extensions using the HubSpot API. The script creates a custom automation extension, retrieves it, updates it, and then deletes it.

## Prerequisites

1. **HubSpot Setup**
   > Refer to the [HubSpot setup guide](https://github.com/ballerina-platform/module-ballerinax-hubspot.automation.actions/tree/main/ballerina/Package.md) to obtain your API key credentials.

2. **Configuration**
   
   Create a `Config.toml` file in the project root directory with your credentials:

   ```toml
   apiKey = "<Your HubSpot API Key>"
   ```

   > **Note:** You will also need to update the `appId` variable in the code with your actual HubSpot App ID.

## Run the Example

Execute the following command to run the example. The script will perform CRUD operations on a HubSpot automation extension and print the results to the console.

```shell
bal run
```

Upon successful execution, you should see output similar to:

```
Extension Created with ID: <extension-id>
Extension Retrieved: <extension-id>
Extension Updated: 
{id:"<extension-id>", ...}
Extension Deleted
```