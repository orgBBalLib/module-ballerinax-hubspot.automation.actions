# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New resource function GET /{appId}/{definitionId}/requires-object to retrieve object requirement status
- New resource function POST /{appId}/{definitionId}/requires-object to set object requirement
- New type PublicActionDefinitionRequiresObjectRequest for setting object requirement
- New type PublicActionDefinitionRequiresObjectResponse for object requirement status response
- New type PublicInputFieldDefinition replacing InputFieldDefinition
- New type PublicFieldTypeDefinition for field type metadata
- New type PublicOption for selectable options
- New type AgentRequestContext for agent-initiated requests
- New type StandaloneRequestContext for standalone automation requests
- New type CopilotRequestContext for HubSpot Copilot requests
- New type WorkflowsRequestContext for workflow-based requests
- New type TestRequestContext for test execution requests
- New type ChirpAiContextObject for AI context and telemetry
- New type ComplianceIds for compliance-related identifiers
- New type ContactId for contact identification
- New type ActionExecutionIndexIdentifier for action execution tracking
- New type IntegerFieldSchema for integer field schema definition
- New type LongFieldSchema for 64-bit integer field schema definition
- New type DoubleFieldSchema for double-precision field schema definition
- New type StringFieldSchema for string field schema definition
- New type BooleanFieldSchema for boolean field schema definition
- New type ArrayFieldSchema for array field schema definition
- New type ObjectFieldSchema for object field schema definition
- requestContext optional field added to CallbackCompletionRequest supporting multiple context types
- requestContext optional field added to CallbackCompletionBatchRequest supporting multiple context types
- failureReasonType optional field added to CallbackCompletionRequest
- failureReasonType optional field added to CallbackCompletionBatchRequest
- privateApp field added to ApiKeysConfig
- referencedObjectType enum in FieldTypeDefinition significantly expanded with new object types
- schema field added to FieldTypeDefinition supporting typed field schemas

### Changed
- InputFieldDefinition type replaced by PublicInputFieldDefinition, removing automationFieldType field
- supportedValueTypes enum in input field definition narrowed from 5 values (STATIC_VALUE, OBJECT_PROPERTY, FIELD_DATA, FETCHED_OBJECT_PROPERTY, ENROLLMENT_EVENT_PROPERTY) to 2 (STATIC_VALUE, OBJECT_PROPERTY)
- CallbackCompletionRequest now requires new mandatory field typedOutputs
- CallbackCompletionBatchRequest now requires new mandatory field typedOutputs
- ApiKeysConfig now requires new mandatory field privateApp
- FieldTypeDefinition now requires new mandatory field useChirp
- API key authentication (hapikey query param and private-app-legacy header) removed from all resource function requests
- GetAppIdGetPageQueries renamed to GetAutomationV4ActionsAppIdGetPageQueries
- GetAppIdDefinitionIdGetByIdQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdGetByIdQueries
- GetAppIdDefinitionIdRevisionsGetPageQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdRevisionsGetPageQueries
- PublicActionDefinitionEggInputFieldDependencies type alias removed
- PublicActionDefinitionPatchInputFieldDependencies type alias removed
- PublicActionDefinition.inputFields type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- PublicActionDefinitionEgg.inputFields type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- PublicActionDefinitionPatch.inputFields type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- Function type enum values reordered across resource function signatures (PRE_ACTION_EXECUTION|PRE_FETCH_OPTIONS|POST_FETCH_OPTIONS|POST_ACTION_EXECUTION to POST_ACTION_EXECUTION|POST_FETCH_OPTIONS|PRE_ACTION_EXECUTION|PRE_FETCH_OPTIONS)

### Fixed
- Auth initialization refactored to use typed local variable eliminating explicit type casts
- Query parameter handling simplified by passing queries record directly instead of spreading into intermediate map
- Comprehensive documentation added to all types and fields throughout types.bal
- Resource functions reordered for improved logical grouping
