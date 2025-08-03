---
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "TodoWrite"]
description: "Create comprehensive test suites and test cases"
usage: "/qa:create [type] [scope] [--framework] [--coverage] [--data]"
---

# Test Creation Engine

Create comprehensive test suites for $ARGUMENTS with proper test cases, data setup, and framework integration.

## Test Creation Process:

1. **Test Planning**
   - Analyze requirements and specifications
   - Identify test scenarios and edge cases
   - Define test data requirements

2. **Test Design**
   - Create test case specifications
   - Design test data and fixtures
   - Plan test environment setup

3. **Test Implementation**
   - Write test code following best practices
   - Implement test data generation
   - Setup test infrastructure

4. **Test Documentation**
   - Document test scenarios and expected outcomes
   - Create test execution guides
   - Maintain test case inventory

## Test Types:

- `unit`: Unit tests for individual functions/methods
- `integration`: Integration tests for component interactions
- `e2e`: End-to-end tests for complete user workflows
- `api`: API tests for backend endpoints
- `performance`: Performance and load tests
- `security`: Security and penetration tests

## Supported Testing Frameworks:

### Frontend Testing
- `jest`: Jest with React Testing Library
- `cypress`: Cypress for E2E testing
- `playwright`: Playwright for cross-browser testing
- `vitest`: Vitest for Vue.js applications

### Backend Testing
- `pytest`: PyTest for Python applications
- `mocha`: Mocha/Chai for Node.js applications
- `junit`: JUnit for Java applications
- `rspec`: RSpec for Ruby applications

### API Testing
- `postman`: Postman collection generation
- `rest-assured`: REST Assured for Java
- `requests`: Python Requests for API testing
- `supertest`: SuperTest for Node.js APIs

## Options:

- `--framework [name]`: Testing framework to use
- `--coverage [percentage]`: Target test coverage percentage
- `--data`: Generate test data and fixtures
- `--parallel`: Enable parallel test execution
- `--watch`: Enable watch mode for development

## Test Structure:

### Unit Tests
```
tests/unit/
├── components/          # Component unit tests
├── services/           # Service layer tests
├── utils/              # Utility function tests
└── fixtures/           # Test data fixtures
```

### Integration Tests
```
tests/integration/
├── api/                # API integration tests
├── database/           # Database integration tests
├── services/           # Service integration tests
└── workflows/          # Business workflow tests
```

### E2E Tests
```
tests/e2e/
├── user-flows/         # Complete user journey tests
├── critical-paths/     # Critical business path tests
├── regression/         # Regression test suites
└── smoke/              # Smoke test suites
```

## Test Coverage Requirements:

### Coverage Targets
- Unit tests: > 80% line coverage
- Integration tests: > 70% branch coverage
- E2E tests: 100% critical path coverage
- API tests: 100% endpoint coverage

### Quality Gates
- All tests must pass before deployment
- Coverage thresholds must be met
- Performance tests must meet SLA requirements
- Security tests must pass vulnerability scans

## Test Data Management:

### Data Generation
- Realistic test data generation
- Edge case and boundary value testing
- Invalid data and error scenario testing
- Large dataset testing for performance

### Data Privacy
- Anonymized production data
- GDPR-compliant test data
- Secure data handling practices
- Data cleanup after testing

## Output:

The command will create:
- Test files in appropriate directory structure
- Test configuration files
- Test data fixtures and generators
- Test documentation and execution guides
- Update project test coverage reports

## Example Usage:

```bash
# Create unit tests with Jest
/qa:create unit src/components --framework jest --coverage 85%

# Create E2E tests with Playwright
/qa:create e2e user-authentication --framework playwright --data

# Create API tests with comprehensive coverage
/qa:create api payment-service --framework pytest --coverage 90%
```

!echo "Creating test suite for: $ARGUMENTS"
!mkdir -p tests/{unit,integration,e2e}