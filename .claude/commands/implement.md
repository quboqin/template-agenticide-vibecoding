---
allowed-tools: ["Read", "Write", "Edit", "MultiEdit", "Bash(npm:*)", "Bash(git:*)", "Glob", "Grep", "TodoWrite"]
description: "Implement features with test-driven and spec-driven development"
usage: "/implement [feature] [--type] [--framework] [--test-driven] [--spec-driven]"
---

# Feature Implementation Engine

Implement $ARGUMENTS following best practices with test-driven development, proper documentation, and quality assurance.

## Implementation Process:

1. **Requirements Analysis**
   - Read specification documents from @specs/
   - Analyze acceptance criteria and user stories
   - Identify dependencies and constraints

2. **Architecture Planning**
   - Design component/module structure
   - Define interfaces and data models
   - Plan integration points

3. **Test-Driven Development**
   - Write tests first based on specifications
   - Implement minimal code to pass tests
   - Refactor and optimize while maintaining tests

4. **Implementation**
   - Write production code following TDD principles
   - Implement proper error handling
   - Add logging and monitoring

5. **Documentation**
   - Update API documentation
   - Add inline code documentation
   - Create usage examples

## Implementation Types:

- `component`: UI component implementation
- `api`: REST API endpoint implementation  
- `service`: Business logic service implementation
- `feature`: Complete feature implementation
- `integration`: Third-party integration implementation

## Supported Frameworks:

### Frontend
- `react`: React with TypeScript
- `vue`: Vue.js with composition API
- `angular`: Angular with TypeScript
- `svelte`: Svelte with TypeScript

### Backend
- `fastapi`: FastAPI with Python
- `express`: Express.js with TypeScript
- `django`: Django with Python
- `spring`: Spring Boot with Java

## Options:

- `--type [component|api|service|feature]`: Implementation type
- `--framework [name]`: Technology framework to use
- `--test-driven`: Enable strict TDD workflow
- `--spec-driven`: Implement based on existing specifications
- `--no-tests`: Skip test generation (not recommended)

## TDD Workflow:

1. **Red**: Write failing tests based on requirements
2. **Green**: Write minimal code to make tests pass
3. **Refactor**: Improve code quality while keeping tests green
4. **Repeat**: Continue cycle for each requirement

## Code Quality Standards:

### General Principles
- Single Responsibility Principle
- Clean and readable code
- Proper error handling
- Comprehensive logging

### Testing Requirements
- Unit test coverage > 80%
- Integration tests for critical paths
- End-to-end tests for user workflows
- Performance tests for critical components

### Documentation Requirements
- API documentation (OpenAPI/Swagger)
- Code comments for complex logic
- README with usage examples
- Changelog with version history

## Output:

The command will create:
- Source code files in appropriate directories
- Test files with comprehensive coverage
- Documentation updates
- Configuration files if needed
- Update todo list with follow-up tasks

## Example Usage:

```bash
# Implement React component with TDD
/implement user-profile-card --type component --framework react --test-driven

# Implement API endpoint
/implement user-authentication --type api --framework fastapi --spec-driven

# Implement complete feature
/implement payment-system --type feature --test-driven --spec-driven
```

!echo "Starting implementation of: $ARGUMENTS"
!git status