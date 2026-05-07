// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

# Complete definition of an automation action including its configuration, fields, and functions.
public type PublicActionDefinition record {
    # Array of function identifiers associated with this action.
    PublicActionFunctionIdentifier[] functions;
    # The URL endpoint where the action is executed.
    string actionUrl;
    # Indicates whether the action definition is published and active.
    boolean published;
    # Localized labels for the action, keyed by language code.
    record {|PublicActionLabels...;|} labels;
    # Array of input field definitions required by the action.
    PublicInputFieldDefinition[] inputFields;
    # Array of output field definitions produced by the action.
    OutputFieldDefinition[] outputFields?;
    # The unique identifier for this revision of the action definition.
    string revisionId;
    # Unix timestamp indicating when the action was archived.
    int archivedAt?;
    # Array of dependencies between input fields.
    PublicActionDefinitionInputFieldDependencies[] inputFieldDependencies?;
    # Array of rules that govern action execution translation.
    PublicExecutionTranslationRule[] executionRules?;
    # The unique identifier for the action definition.
    string id;
    # Array of HubSpot object types this action can operate on.
    string[] objectTypes;
    # Configuration options for object requests specifying which properties to include.
    PublicObjectRequestOptions objectRequestOptions?;
};

# Defines a conditional dependency where fields depend on a specific controlling field value.
public type PublicConditionalSingleFieldDependency record {
    # The type of dependency, with the default value being CONDITIONAL_SINGLE_FIELD
    "CONDITIONAL_SINGLE_FIELD" dependencyType = "CONDITIONAL_SINGLE_FIELD";
    # The name of the field that determines the dependency
    string controllingFieldName;
    # The value of the controlling field that triggers the dependency
    string controllingFieldValue;
    # Array of field names that depend on the controlling field's value.
    string[] dependentFieldNames;
};

# Context object for agent-initiated requests containing agent and AI context details.
public type AgentRequestContext record {
    # The unique identifier for the trajectory associated with the agent request
    string trajectoryId?;
    # The unique identifier for the agent making the request
    int agentId;
    # Indicates the source of the request, with the default value being 'AGENTS'
    "AGENTS" 'source = "AGENTS";
    # Contains AI context information including application details and telemetry data.
    ChirpAiContextObject chirpAiContextObject;
};

# Schema definition for a 64-bit integer field with optional minimum and maximum values.
public type LongFieldSchema record {
    # The maximum value allowed for the long field
    int maximum?;
    # The type of the field, which is LONG by default
    "LONG" 'type = "LONG";
    # The minimum value allowed for the long field
    int minimum?;
};

# Defines display labels and descriptions for an action and its input/output fields.
public type PublicActionLabels record {
    # Descriptions for each input field
    record {|string...;|} inputFieldDescriptions?;
    # The display name of the application associated with the action
    string appDisplayName?;
    # Labels for the output fields
    record {|string...;|} outputFieldLabels?;
    # A description of what the action does
    string actionDescription?;
    # Rules that govern the execution of the action
    record {|string...;|} executionRules?;
    # Labels for the options available in input fields
    record {|record {|string...;|}...;|} inputFieldOptionLabels?;
    # Content displayed on the action card
    string actionCardContent?;
    # The name of the action
    string actionName;
    # Labels for the input fields
    record {|string...;|} inputFieldLabels?;
};

# Identifies a specific action execution within an enrollment by its index and enrollment ID.
public type ActionExecutionIndexIdentifier record {
    # The ID associated with the enrollment process
    int enrollmentId;
    # The index number representing the execution order of the action
    int:Signed32 actionExecutionIndex;
};

# Contains pagination information for navigating forward through result sets.
public type ForwardPaging record {
    # Specifies the paging information needed to retrieve the next set of results in a paginated API response
    NextPage next?;
};

# Represents the Queries record for the operation: get-/automation/v4/actions/{appId}/{definitionId}_getById
public type GetAutomationV4ActionsAppIdDefinitionIdGetByIdQueries record {
    # Whether to return only results that have been archived
    boolean archived = false;
};

# Comprehensive definition of a field's type, schema, options, and display properties.
public type FieldTypeDefinition record {
    # Defines the structure and constraints of the field
    IntegerFieldSchema|LongFieldSchema|DoubleFieldSchema|StringFieldSchema|BooleanFieldSchema|ArrayFieldSchema|ObjectFieldSchema schema;
    # Additional information or guidance about the field
    string helpText?;
    # A detailed explanation of the field's purpose and usage
    string description?;
    # The user-friendly label for the field
    string label?;
    # Specifies whether the field uses the Chirp feature
    boolean useChirp;
    # Specifies the data type of the field, with accepted values like bool, date, datetime, enumeration, json, number, object_coordinates, phone_number, string
    "bool"|"currency_number"|"date"|"datetime"|"enumeration"|"json"|"number"|"object_coordinates"|"phone_number"|"string" 'type;
    # Indicates the type of object that the field references, with accepted values like OWNER
    "ABANDONED_CART"|"ACCEPTANCE_TEST"|"AD"|"AD_ACCOUNT"|"AD_CAMPAIGN"|"AD_GROUP"|"AI_FORECAST"|"ALL_PAGES"|"APPROVAL"|"APPROVAL_STEP"|"ATTRIBUTION"|"AUDIENCE"|"AUTOMATION_JOURNEY"|"AUTOMATION_PLATFORM_FLOW"|"AUTOMATION_PLATFORM_FLOW_ACTION"|"BET_ALERT"|"BET_DELIVERABLE_SERVICE"|"BLOG_LISTING_PAGE"|"BLOG_POST"|"CALL"|"CAMPAIGN"|"CAMPAIGN_BUDGET_ITEM"|"CAMPAIGN_SPEND_ITEM"|"CAMPAIGN_STEP"|"CAMPAIGN_TEMPLATE"|"CAMPAIGN_TEMPLATE_STEP"|"CART"|"CASE_STUDY"|"CHATFLOW"|"CLIP"|"CMS_URL"|"COMBO_EVENT_CONFIGURATION"|"COMMERCE_PAYMENT"|"COMMUNICATION"|"COMPANY"|"CONTACT"|"CONTACT_CREATE_ATTRIBUTION"|"CONTENT"|"CONTENT_AUDIT"|"CONTENT_AUDIT_PAGE"|"CONVERSATION"|"CONVERSATION_INBOX"|"CONVERSATION_SESSION"|"CRM_OBJECTS_DUMMY_TYPE"|"CRM_PIPELINES_DUMMY_TYPE"|"CTA"|"CTA_VARIANT"|"DATA_PRIVACY_CONSENT"|"DATA_SYNC_STATE"|"DEAL"|"DEAL_CREATE_ATTRIBUTION"|"DEAL_REGISTRATION"|"DEAL_SPLIT"|"DISCOUNT"|"DISCOUNT_CODE"|"DISCOUNT_TEMPLATE"|"EMAIL"|"ENGAGEMENT"|"EXPORT"|"EXTERNAL_WEB_URL"|"FEE"|"FEEDBACK_SUBMISSION"|"FEEDBACK_SURVEY"|"FILE_MANAGER_FILE"|"FILE_MANAGER_FOLDER"|"FOLDER"|"FORECAST"|"FORM"|"FORM_SUBMISSION_INBOUNDDB"|"GOAL_TARGET"|"GOAL_TARGET_GROUP"|"GOAL_TEMPLATE"|"GSC_PROPERTY"|"HUB"|"IMPORT"|"INVOICE"|"KEYWORD"|"KNOWLEDGE_ARTICLE"|"LANDING_PAGE"|"LEAD"|"LINE_ITEM"|"MARKETING_CALENDAR"|"MARKETING_CAMPAIGN_UTM"|"MARKETING_EMAIL"|"MARKETING_EVENT"|"MARKETING_EVENT_ATTENDANCE"|"MARKETING_SMS"|"MEDIA_BRIDGE"|"MEETING_EVENT"|"MIC"|"NOTE"|"OBJECT_LIST"|"ORDER"|"OWNER"|"PARTNER_ACCOUNT"|"PARTNER_CLIENT"|"PARTNER_CLIENT_REVENUE"|"PARTNER_SERVICE"|"PAYMENT_LINK"|"PAYMENT_SCHEDULE"|"PAYMENT_SCHEDULE_INSTALLMENT"|"PERMISSIONS_TESTING"|"PLAYBOOK"|"PLAYBOOK_QUESTION"|"PLAYBOOK_SUBMISSION"|"PLAYBOOK_SUBMISSION_ANSWER"|"PLAYLIST"|"PLAYLIST_FOLDER"|"PODCAST_EPISODE"|"PORTAL"|"PORTAL_OBJECT_SYNC_MESSAGE"|"POSTAL_MAIL"|"PRIVACY_SCANNER_COOKIE"|"PRODUCT"|"PRODUCT_OR_FOLDER"|"PROPERTY_INFO"|"PROSPECTING_AGENT_CONTACT_ASSIGNMENT"|"PUBLISHING_TASK"|"QUARANTINED_SUBMISSION"|"QUOTA"|"QUOTE"|"QUOTE_FIELD"|"QUOTE_MODULE"|"QUOTE_MODULE_FIELD"|"QUOTE_TEMPLATE"|"RESTORABLE_CRM_OBJECT"|"ROSTER"|"ROSTER_MEMBER"|"SALES_DOCUMENT"|"SALES_TASK"|"SALES_WORKLOAD"|"SALESFORCE_SYNC_ERROR"|"SCHEDULING_PAGE"|"SCHEMAS_BACKEND_TEST"|"SCORE_CONFIGURATION"|"SEQUENCE"|"SEQUENCE_ENROLLMENT"|"SEQUENCE_STEP"|"SEQUENCE_STEP_ENROLLMENT"|"SERVICE"|"SITE_PAGE"|"SNIPPET"|"SOCIAL_BROADCAST"|"SOCIAL_CHANNEL"|"SOCIAL_POST"|"SOCIAL_PROFILE"|"SOX_PROTECTED_DUMMY_TYPE"|"SOX_PROTECTED_TEST_TYPE"|"SUBMISSION_TAG"|"SUBSCRIPTION"|"TASK"|"TASK_TEMPLATE"|"TAX"|"TEMPLATE"|"TICKET"|"UNKNOWN"|"UNSUBSCRIBE"|"USER"|"VIEW"|"VIEW_BLOCK"|"WEB_INTERACTIVE" referencedObjectType?;
    # The unique identifier for the field
    string name;
    # Array of available option values for selection-based fields.
    Option[] options;
    # Specifies the type of external reference for options
    string externalOptionsReferenceType?;
    # Indicates whether the field's options are sourced externally
    boolean externalOptions;
    # Describes the field's type in the UI, with accepted values like booleancheckbox, calculation_equation, checkbox, date, file, html, number, phonenumber, radio, select, text, textarea, unknown
    "booleancheckbox"|"calculation_equation"|"calculation_read_time"|"calculation_rollup"|"calculation_score"|"checkbox"|"date"|"file"|"html"|"number"|"phonenumber"|"radio"|"select"|"text"|"textarea"|"unknown" fieldType?;
    # A URL that provides options for the field
    string optionsUrl?;
};

# Request context for standalone automation actions not tied to a workflow.
public type StandaloneRequestContext record {
    # A unique identifier for tracking the trajectory of the request
    string trajectoryId?;
    # Indicates the source of the request, with the default value being 'STANDALONE'
    "STANDALONE" 'source = "STANDALONE";
    # Contains AI context information including application details and telemetry data.
    ChirpAiContextObject chirpAiContextObject;
};

# Schema definition for integer fields with optional minimum and maximum constraints.
public type IntegerFieldSchema record {
    # The maximum value allowed for the integer field
    int:Signed32 maximum?;
    # The type of the field, which is set to INTEGER
    "INTEGER" 'type = "INTEGER";
    # The minimum value allowed for the integer field
    int:Signed32 minimum?;
};

# Identifies a function by its type and unique identifier within an automation action.
public type PublicActionFunctionIdentifier record {
    # The type of function, with accepted values: POST_ACTION_EXECUTION, POST_FETCH_OPTIONS, PRE_ACTION_EXECUTION, PRE_FETCH_OPTIONS
    "POST_ACTION_EXECUTION"|"POST_FETCH_OPTIONS"|"PRE_ACTION_EXECUTION"|"PRE_FETCH_OPTIONS" functionType;
    # The unique identifier for the function
    string id?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Provides Auth configurations needed when communicating with a remote HTTP endpoint.
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig|ApiKeysConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# Request payload for completing an automation callback with output fields and context.
public type CallbackCompletionRequest record {
    # Contains the output fields associated with the callback, with each field represented as a key-value pair
    record {|string...;|} outputFields;
    # Holds the typed outputs related to the callback, structured as an object
    record {} typedOutputs;
    # Specifies the context in which the request is made, which can be one of several predefined contexts
    WorkflowsRequestContext|AgentRequestContext|CopilotRequestContext|StandaloneRequestContext|TestRequestContext requestContext?;
    # Indicates the reason for the failure of a callback completion
    string failureReasonType?;
};

# Paginated response containing a collection of public action definitions.
public type CollectionResponsePublicActionDefinitionForwardPaging record {
    # Contains pagination information for navigating forward through result sets.
    ForwardPaging paging?;
    # Array of public action definitions returned in the response.
    PublicActionDefinition[] results;
};

# Represents the Queries record for the operation: get-/automation/v4/actions/{appId}/{definitionId}/revisions_getPage
public type GetAutomationV4ActionsAppIdDefinitionIdRevisionsGetPageQueries record {
    # The maximum number of results to display per page
    int:Signed32 'limit?;
    # The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results
    string after?;
};

# Request context indicating the request originated from HubSpot Copilot.
public type CopilotRequestContext record {
    # The unique identifier for the trajectory
    string trajectoryId?;
    # Indicates the source of the request, with the default value being 'COPILOT'
    "COPILOT" 'source = "COPILOT";
};

# Request payload specifying whether an action definition requires an associated object.
public type PublicActionDefinitionRequiresObjectRequest record {
    # Indicates whether a custom action definition requires an associated object
    boolean requiresObject;
};

# Schema definition for string-type fields with optional format specification.
public type StringFieldSchema record {
    # Specifies the format of the string, with accepted values: DATE, DATE_TIME, OBJECT_COORDINATE, TIME, URI
    "DATE"|"DATE_TIME"|"OBJECT_COORDINATE"|"TIME"|"URI" format?;
    # Indicates that the type is a string, with the default value being STRING
    "STRING" 'type = "STRING";
};

# Container for batch callback completion requests.
public type BatchInputCallbackCompletionBatchRequest record {
    # Array of callback completion requests to process in batch.
    CallbackCompletionBatchRequest[] inputs;
};

# Schema definition for array-type fields containing typed elements.
public type ArrayFieldSchema record {
    # Specifies that the field is of type 'ARRAY'
    "ARRAY" 'type = "ARRAY";
    # Defines the type of elements contained within the array, which can be an integer, long, double, string, boolean, another array, or an object
    IntegerFieldSchema|LongFieldSchema|DoubleFieldSchema|StringFieldSchema|BooleanFieldSchema|ArrayFieldSchema|ObjectFieldSchema items;
};

# A HubSpot property option
public type Option record {
    # Whether the option is displayed in HubSpot's UI
    boolean hidden;
    # The position of the item relative to others in the list
    int:Signed32 displayOrder;
    # A numerical value associated with the option
    decimal doubleData;
    # A description of the option
    string description;
    # Whether the option is read-only
    boolean readOnly;
    # A user-friendly label that identifies the option
    string label;
    # The actual value of the option
    string value;
};

# Defines an output field returned by an automation action.
public type OutputFieldDefinition record {
    # Comprehensive definition of a field's type, schema, options, and display properties.
    FieldTypeDefinition typeDefinition;
};

# Provides API key configurations needed when communicating with a remote HTTP endpoint.
public type ApiKeysConfig record {|
    string hapikey;
    string privateApp;
    string privateAppLegacy;
|};

# Context object for test requests indicating the source is a test execution.
public type TestRequestContext record {
    # Indicates the source of the test request, with the only accepted value being 'TEST'
    "TEST" 'source = "TEST";
};

# Defines the structure and metadata for a field type used in automation actions.
public type PublicFieldTypeDefinition record {
    # Additional information or guidance about the field
    string helpText?;
    # The type of object that the field references, with accepted values including OWNER
    "OWNER" referencedObjectType?;
    # The internal name used to identify the field
    string name;
    # Array of available options for enumeration or selection fields.
    PublicOption[] options;
    # A detailed explanation of the field's purpose
    string description?;
    # A user-friendly name for the field
    string label?;
    # The data type of the field, with accepted values including bool, date, datetime, enumeration, json, number, object_coordinates, phone_number, and string
    "bool"|"date"|"datetime"|"enumeration"|"json"|"number"|"object_coordinates"|"phone_number"|"string" 'type;
    # The type of field, with accepted values including booleancheckbox, calculation_equation, checkbox, date, file, html, number, phonenumber, radio, select, text, and textarea
    "booleancheckbox"|"calculation_equation"|"checkbox"|"date"|"file"|"html"|"number"|"phonenumber"|"radio"|"select"|"text"|"textarea" fieldType?;
    # A URL that provides options for the field
    string optionsUrl?;
};

# Defines a function associated with an automation action, including its source code and type.
public type PublicActionFunction record {
    # The source code or script that defines the function's behavior
    string functionSource;
    # The type of function, with accepted values: POST_ACTION_EXECUTION, POST_FETCH_OPTIONS, PRE_ACTION_EXECUTION, PRE_FETCH_OPTIONS
    "POST_ACTION_EXECUTION"|"POST_FETCH_OPTIONS"|"PRE_ACTION_EXECUTION"|"PRE_FETCH_OPTIONS" functionType;
    # The unique identifier for the action function
    string id?;
};

# Represents a selectable option with a label and value for field configurations.
public type PublicOption record {
    # The position of the option relative to others in the list
    int:Signed32 displayOrder?;
    # A description of the option
    string description?;
    # A user-friendly label that identifies the option
    string label;
    # The actual value of the option
    string value;
};

# Response indicating whether an action definition requires an associated object.
public type PublicActionDefinitionRequiresObjectResponse record {
    # Indicates whether a custom action definition requires an object
    boolean requiresObject;
};

# Union type representing either a single field or conditional single field dependency.
public type PublicActionDefinitionInputFieldDependencies PublicSingleFieldDependency|PublicConditionalSingleFieldDependency;

# Contains AI context information including application details and telemetry data.
public type ChirpAiContextObject record {
    # The identifier for the trajectory, formatted as a UUID
    string trajectoryId?;
    # Additional metadata related to the context, represented as key-value pairs
    record {|string...;|} metadata;
    # Holds OpenTelemetry context information as key-value pairs
    record {|string...;|} otelContextHolder;
    # Unique identifier for the conversation session.
    string conversationId?;
    # The group to which the application belongs
    string applicationGroup;
    # The identifier for the inference associated with the context
    string inferenceId?;
    # Array of source types for unstructured data inputs.
    ("NONE"|"USER_INPUT"|"LOGGED_EMAIL"|"VIDEO_CALL"|"AUDIO_CALL"|"CALL_TRANSCRIPT"|"MEETING_TRANSCRIPT"|"FORMS"|"FEEDBACK_SURVEY"|"PDF"|"QUOTE"|"INVOICE"|"OTHER_ATTACHMENT_DOC"|"WHATSAPP"|"SMS"|"CHAT"|"FACEBOOK_MESSENGER"|"CUSTOM_CHANNEL_OR_API"|"MANY"|"NOTE"|"DERIVED")[] unstructuredSources;
    # Indicates whether the context data is private.
    boolean isPrivate;
    # The identifier for the application associated with the context
    string applicationId;
    # Contains compliance-related identifiers for contacts, portals, and users.
    ComplianceIds complianceIds?;
    # The identifier for the feature associated with the context
    string featureId?;
};

# Identifies a contact using portal ID, contact ID, or email address.
public type ContactId record {
    # The unique identifier for the contact
    int vid?;
    # The ID of the portal associated with the contact
    int:Signed32 portalId;
    # The email address of the contact
    string email?;
};

# Schema definition for a double-precision floating-point field with optional bounds.
public type DoubleFieldSchema record {
    # The maximum allowable value for the double field
    decimal maximum?;
    # Indicates the field type as DOUBLE
    "DOUBLE" 'type = "DOUBLE";
    # The minimum allowable value for the double field
    decimal minimum?;
};

# Configuration options for object requests specifying which properties to include.
public type PublicObjectRequestOptions record {
    # Array of property names to include in the request.
    string[] properties;
};

# Defines a dependency where fields are controlled by another field's presence.
public type PublicSingleFieldDependency record {
    # The type of dependency, with the default value being 'SINGLE_FIELD'
    "SINGLE_FIELD" dependencyType = "SINGLE_FIELD";
    # The name of the field that controls the dependency
    string controllingFieldName;
    # Array of field names that depend on the controlling field.
    string[] dependentFieldNames;
};

# Defines the structure and requirements for an input field in automation actions.
public type PublicInputFieldDefinition record {
    # Indicates whether the input field is mandatory
    boolean isRequired;
    # Defines the structure and metadata for a field type used in automation actions.
    PublicFieldTypeDefinition typeDefinition;
    # Array of value types the field accepts (STATIC_VALUE or OBJECT_PROPERTY).
    ("STATIC_VALUE"|"OBJECT_PROPERTY")[] supportedValueTypes?;
};

# Response containing a collection of action function identifiers without pagination.
public type CollectionResponsePublicActionFunctionIdentifierNoPaging record {
    # Array of action function identifiers returned in the response.
    PublicActionFunctionIdentifier[] results;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://api.hubapi.com/oauth/v1/token";
|};

# Defines translation rules for action execution based on specified conditions.
public type PublicExecutionTranslationRule record {
    # Defines the conditions that must be met for the execution rule to apply
    record {|record {}...;|} conditions;
    # Specifies the name of the label associated with the execution rule
    string labelName;
};

# Request context containing workflow and action identifiers for workflow-based requests.
public type WorkflowsRequestContext record {
    # Identifies a specific action execution within an enrollment by its index and enrollment ID.
    ActionExecutionIndexIdentifier actionExecutionIndexIdentifier?;
    # The ID of the action within the workflow context
    int actionId?;
    # Indicates the source of the request, with the default value being WORKFLOWS
    "WORKFLOWS" 'source = "WORKFLOWS";
    # The ID of the workflow associated with the request context
    int workflowId;
};

# Contains compliance-related identifiers for contacts, portals, and users.
public type ComplianceIds record {
    # The reason why no contact ID is available
    string noContactIdReason?;
    # The reason why no portal ID is available
    string noPortalIdReason?;
    # Array of user IDs associated with compliance tracking.
    int:Signed32[] userIds;
    # Array of portal IDs associated with compliance tracking.
    int:Signed32[] portalIds;
    # The reason why no user ID is available
    string noUserIdReason?;
    # Array of contact identifiers for compliance tracking.
    ContactId[] contactIds;
};

# Represents a specific revision of an automation action with its definition and metadata.
public type PublicActionRevision record {
    # The unique identifier for the specific revision of the action
    string revisionId;
    # The date and time when the action revision was created
    string createdAt;
    # Complete definition of an automation action including its configuration, fields, and functions.
    PublicActionDefinition definition;
    # The unique identifier for the action revision
    string id;
};

# Represents the Queries record for the operation: get-/automation/v4/actions/{appId}_getPage
public type GetAutomationV4ActionsAppIdGetPageQueries record {
    # Whether to return only results that have been archived
    boolean archived = false;
    # The maximum number of results to display per page
    int:Signed32 'limit?;
    # The paging cursor token of the last successfully read resource will be returned as the `paging.next.after` JSON property of a paged response containing more results
    string after?;
};

# Paginated response containing a collection of public action revisions.
public type CollectionResponsePublicActionRevisionForwardPaging record {
    # Contains pagination information for navigating forward through result sets.
    ForwardPaging paging?;
    # Array of public action revisions returned in the response.
    PublicActionRevision[] results;
};

# Batch request payload for completing multiple automation callbacks simultaneously.
public type CallbackCompletionBatchRequest record {
    # Holds the output fields for the callback completion
    record {|string...;|} outputFields;
    # Contains the typed outputs for the callback completion
    record {} typedOutputs;
    # Defines the context of the request, which can be one of several predefined types
    WorkflowsRequestContext|AgentRequestContext|CopilotRequestContext|StandaloneRequestContext|TestRequestContext requestContext?;
    # The unique identifier for the callback
    string callbackId;
    # Specifies the type of failure reason for the callback completion
    string failureReasonType?;
};

# Template for creating a new public action definition with all required configurations.
public type PublicActionDefinitionEgg record {
    # Array of input field definitions required by the action.
    PublicInputFieldDefinition[] inputFields;
    # Array of output field definitions produced by the action.
    OutputFieldDefinition[] outputFields?;
    # The timestamp indicating when the action was archived
    int archivedAt?;
    # Array of functions associated with the action execution.
    PublicActionFunction[] functions;
    # The URL endpoint where the action is executed
    string actionUrl;
    # Array of dependencies between input fields for conditional field behavior.
    PublicActionDefinitionInputFieldDependencies[] inputFieldDependencies?;
    # Array of translation rules applied during action execution.
    PublicExecutionTranslationRule[] executionRules?;
    # Indicates whether the action is published and available for use
    boolean published;
    # Array of HubSpot object types this action can operate on.
    string[] objectTypes;
    # Holds various labels associated with the action, including names and descriptions
    record {|PublicActionLabels...;|} labels;
    # Configuration options for object requests specifying which properties to include.
    PublicObjectRequestOptions objectRequestOptions?;
};

# Schema for partially updating an existing automation action definition.
public type PublicActionDefinitionPatch record {
    # Array of input field definitions for the action.
    PublicInputFieldDefinition[] inputFields?;
    # Array of output field definitions returned by the action.
    OutputFieldDefinition[] outputFields?;
    # The URL endpoint where the action is executed
    string actionUrl?;
    # Array of dependencies between input fields for conditional behavior.
    PublicActionDefinitionInputFieldDependencies[] inputFieldDependencies?;
    # Array of translation rules applied during action execution.
    PublicExecutionTranslationRule[] executionRules?;
    # Indicates whether the action is published and available for use
    boolean published?;
    # Array of HubSpot object types this action can operate on.
    string[] objectTypes?;
    # Contains labels for the action, including names and descriptions
    record {|PublicActionLabels...;|} labels?;
    # Configuration options for object requests specifying which properties to include.
    PublicObjectRequestOptions objectRequestOptions?;
};

# Schema definition for boolean-type fields holding true or false values.
public type BooleanFieldSchema record {
    # Specifies the field type as BOOLEAN, indicating that the field can hold a true or false value
    "BOOLEAN" 'type = "BOOLEAN";
};

# Specifies the paging information needed to retrieve the next set of results in a paginated API response
public type NextPage record {
    # A URL that can be used to retrieve the next page results
    string link?;
    # A paging cursor token for retrieving subsequent pages
    string after;
};

# Schema definition for object-type fields with nested properties.
public type ObjectFieldSchema record {
    # Specifies the type of the field, which is 'OBJECT' by default
    "OBJECT" 'type = "OBJECT";
    # Contains the properties of the object
    record {} properties;
};