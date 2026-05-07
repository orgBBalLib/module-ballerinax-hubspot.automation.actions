# Change Log

This file contains all the notable changes done to the Ballerina connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New resource functions for object requirement: GET /{appId}/{definitionId}/requires-object and POST /{appId}/{definitionId}/requires-object
- New types: PublicActionDefinitionRequiresObjectRequest and PublicActionDefinitionRequiresObjectResponse
- New request context types: WorkflowsRequestContext, AgentRequestContext, CopilotRequestContext, StandaloneRequestContext, TestRequestContext
- New supporting types: ChirpAiContextObject, ComplianceIds, ContactId, ActionExecutionIndexIdentifier
- New field schema types: IntegerFieldSchema, LongFieldSchema, DoubleFieldSchema, StringFieldSchema, BooleanFieldSchema, ArrayFieldSchema, ObjectFieldSchema
- New PublicFieldTypeDefinition type for public-facing field type definitions
- New PublicOption type as a simpler alternative to Option
- New PublicInputFieldDefinition type replacing InputFieldDefinition
- privateApp field added to ApiKeysConfig
- requestContext and failureReasonType optional fields added to CallbackCompletionRequest and CallbackCompletionBatchRequest
- Expanded referencedObjectType enum in FieldTypeDefinition with many new object types
- Comprehensive doc comments added to all types and fields

### Changed
- API key authentication (hapikey, private-app-legacy) removed from all resource functions - clients using ApiKeysConfig will silently fail authentication
- InputFieldDefinition type replaced by PublicInputFieldDefinition with narrower supportedValueTypes (removed FIELD_DATA, FETCHED_OBJECT_PROPERTY, ENROLLMENT_EVENT_PROPERTY)
- PublicInputFieldDefinition uses PublicFieldTypeDefinition instead of FieldTypeDefinition, changing the typeDefinition field type
- FieldTypeDefinition now has a required useChirp boolean field - existing code constructing this type will break
- FieldTypeDefinition now has a required schema field - existing code constructing this type will break
- CallbackCompletionRequest now has a required typedOutputs field - existing code constructing this type will break
- CallbackCompletionBatchRequest now has a required typedOutputs field - existing code constructing this type will break
- PublicActionDefinitionEggInputFieldDependencies and PublicActionDefinitionPatchInputFieldDependencies type aliases removed
- GetAppIdGetPageQueries renamed to GetAutomationV4ActionsAppIdGetPageQueries
- GetAppIdDefinitionIdGetByIdQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdGetByIdQueries
- GetAppIdDefinitionIdRevisionsGetPageQueries renamed to GetAutomationV4ActionsAppIdDefinitionIdRevisionsGetPageQueries
- PublicActionDefinitionEgg and PublicActionDefinitionPatch inputFields type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]
- PublicActionDefinition inputFields type changed from InputFieldDefinition[] to PublicInputFieldDefinition[]

### Fixed
- Auth configuration handling in init() refactored to use typed local variable instead of repeated casting
- Query parameters now passed directly to getPathForQueryParam instead of spreading into intermediate map
