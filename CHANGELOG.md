# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New resource function GET /{appId}/{definitionId}/requires-object to retrieve object requirement status
- New resource function POST /{appId}/{definitionId}/requires-object to set object requirement
- New types for request contexts: WorkflowsRequestContext, AgentRequestContext, CopilotRequestContext, StandaloneRequestContext, TestRequestContext
- New ChirpAiContextObject type for AI context with telemetry data
- New ComplianceIds type for compliance tracking
- New ContactId type for contact identification
- New ActionExecutionIndexIdentifier type
- New PublicActionDefinitionRequiresObjectRequest and PublicActionDefinitionRequiresObjectResponse types
- New field schema types: IntegerFieldSchema, LongFieldSchema, DoubleFieldSchema, StringFieldSchema, BooleanFieldSchema, ArrayFieldSchema, ObjectFieldSchema
- New PublicFieldTypeDefinition type as public-facing field type metadata
- New PublicOption type as public-facing selectable option
- New PublicInputFieldDefinition type replacing InputFieldDefinition
- requestContext and failureReasonType optional fields added to callback completion requests
- Expanded referencedObjectType enum in FieldTypeDefinition with many new object types
- schema field added to FieldTypeDefinition supporting union of all new field schema types

### Changed
- ApiKeysConfig now requires a new mandatory field 'privateApp', breaking existing record construction
- InputFieldDefinition replaced by PublicInputFieldDefinition with incompatible structure
- CallbackCompletionRequest now requires mandatory field 'typedOutputs'
- CallbackCompletionBatchRequest now requires mandatory field 'typedOutputs'
- supportedValueTypes in input field definition narrowed from 5 values (STATIC_VALUE, OBJECT_PROPERTY, FIELD_DATA, FETCHED_OBJECT_PROPERTY, ENROLLMENT_EVENT_PROPERTY) to 2 (STATIC_VALUE, OBJECT_PROPERTY)
- automationFieldType field removed from input field definition
- FieldTypeDefinition now requires mandatory field 'useChirp' with no default value
- typeDefinition field in input definitions changed from FieldTypeDefinition to PublicFieldTypeDefinition
- PublicActionDefinitionEggInputFieldDependencies type removed
- PublicActionDefinitionPatchInputFieldDependencies type removed
- API key injection per-request removed from all resource functions, breaking existing API key authentication flow
- functionType enum values reordered in resource function path parameters, potentially breaking pattern-matched clients
- GetAppIdGetPageQueries renamed to GetAutomationV4ActionsAppIdGetPageQueries
- GetAppIdDefinitionIdGetByIdQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdGetByIdQueries
- GetAppIdDefinitionIdRevisionsGetPageQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdRevisionsGetPageQueries

### Fixed
- Auth initialization refactored to use typed local variable, avoiding repeated casting
- Query parameter handling simplified by passing queries record directly instead of copying to intermediate map
- API key and auth configuration now handled at HTTP client level rather than per-request injection
