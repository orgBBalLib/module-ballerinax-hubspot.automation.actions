# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New resource functions for requires-object endpoint: GET and POST /{appId}/{definitionId}/requires-object
- New types: AgentRequestContext, StandaloneRequestContext, CopilotRequestContext, WorkflowsRequestContext, TestRequestContext
- New type: ChirpAiContextObject for AI context metadata
- New type: ComplianceIds for compliance tracking
- New type: ContactId for contact identification
- New type: ActionExecutionIndexIdentifier for action execution tracking
- New field schema types: IntegerFieldSchema, LongFieldSchema, DoubleFieldSchema, StringFieldSchema, BooleanFieldSchema, ArrayFieldSchema, ObjectFieldSchema
- New type: PublicFieldTypeDefinition
- New type: PublicInputFieldDefinition
- New type: PublicOption
- New type: PublicActionDefinitionRequiresObjectRequest
- New type: PublicActionDefinitionRequiresObjectResponse
- New optional fields in CallbackCompletionRequest: typedOutputs, requestContext, failureReasonType
- New optional fields in CallbackCompletionBatchRequest: typedOutputs, requestContext, failureReasonType
- New privateApp field added to ApiKeysConfig
- FieldTypeDefinition expanded with schema field and useChirp boolean field
- Expanded referencedObjectType enum in FieldTypeDefinition with many new HubSpot object types
- Doc comments added to all types and fields

### Changed
- InputFieldDefinition type removed and replaced with PublicInputFieldDefinition, which has a different typeDefinition field type (PublicFieldTypeDefinition instead of FieldTypeDefinition) and narrowed supportedValueTypes enum (only STATIC_VALUE and OBJECT_PROPERTY, removing FIELD_DATA, FETCHED_OBJECT_PROPERTY, ENROLLMENT_EVENT_PROPERTY)
- PublicActionDefinitionEggInputFieldDependencies type removed
- PublicActionDefinitionPatchInputFieldDependencies type removed
- GetAppIdGetPageQueries renamed to GetAutomationV4ActionsAppIdGetPageQueries
- GetAppIdDefinitionIdGetByIdQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdGetByIdQueries
- GetAppIdDefinitionIdRevisionsGetPageQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdRevisionsGetPageQueries
- PublicActionFunctionIdentifier functionType enum order changed from PRE_ACTION_EXECUTION|PRE_FETCH_OPTIONS|POST_FETCH_OPTIONS|POST_ACTION_EXECUTION to POST_ACTION_EXECUTION|POST_FETCH_OPTIONS|PRE_ACTION_EXECUTION|PRE_FETCH_OPTIONS
- PublicActionFunction functionType enum order changed similarly, which may affect pattern matching
- Resource function path segment functions by type enum order changed, breaking URL path matching for PRE_ACTION_EXECUTION|PRE_FETCH_OPTIONS|POST_FETCH_OPTIONS|POST_ACTION_EXECUTION
- ApiKeysConfig credentials (hapikey and privateAppLegacy) no longer injected into requests, silently breaking API key authentication
- PublicActionDefinition inputFields field type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- PublicActionDefinitionEgg inputFields field type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- PublicActionDefinitionPatch inputFields field type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]

### Fixed
- Auth config handling improved by eliminating unsafe type casts using a local variable for type narrowing
- Query parameter handling simplified by passing queries directly to getPathForQueryParam
