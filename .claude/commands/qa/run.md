---
allowed-tools: ["Bash(npm test:*)", "Bash(pytest:*)", "Bash(docker:*)", "Read", "Write", "Grep", "TodoWrite"]
description: "Execute test suites with comprehensive reporting and analysis"
usage: "/qa:run [suite] [environment] [--parallel] [--coverage] [--report]"
---

# Test Execution Engine

Execute test suites for $ARGUMENTS with parallel execution, coverage analysis, and comprehensive reporting.

## Test Execution Process:

1. **Environment Setup**
   - Validate test environment configuration
   - Setup test databases and services
   - Initialize test data and fixtures

2. **Test Execution**
   - Run test suites in specified order
   - Monitor test execution progress
   - Capture test results and metrics

3. **Results Analysis**
   - Analyze test results and failures
   - Generate coverage reports
   - Identify flaky tests and patterns

4. **Reporting**
   - Generate comprehensive test reports
   - Create failure analysis documentation
   - Update test metrics dashboard

## Test Suites:

- `unit`: Execute unit test suite
- `integration`: Execute integration test suite
- `e2e`: Execute end-to-end test suite
- `api`: Execute API test suite
- `performance`: Execute performance test suite
- `security`: Execute security test suite
- `regression`: Execute regression test suite
- `smoke`: Execute smoke test suite
- `all`: Execute all test suites

## Test Environments:

- `local`: Local development environment
- `development`: Development server environment
- `staging`: Staging environment with production-like data
- `production`: Production environment (limited tests only)

## Options:

- `--parallel`: Enable parallel test execution
- `--coverage`: Generate code coverage reports
- `--report`: Generate detailed HTML/XML reports
- `--retry [number]`: Retry failed tests specified number of times
- `--timeout [seconds]`: Set test timeout duration
- `--filter [pattern]`: Run only tests matching pattern

## Execution Strategies:

### Parallel Execution
- Distribute tests across multiple processes
- Optimize test execution time
- Manage shared resources and dependencies
- Aggregate results from parallel runs

### Test Isolation
- Ensure tests don't interfere with each other
- Clean up test data between runs
- Reset application state between tests
- Manage database transactions properly

### Retry Logic
- Automatically retry flaky tests
- Identify and report consistently failing tests
- Implement exponential backoff for retries
- Track retry patterns and success rates

## Performance Monitoring:

### Execution Metrics
- Test execution time per suite
- Individual test performance
- Resource utilization during tests
- Memory and CPU usage patterns

### Quality Metrics
- Test pass/fail rates
- Flaky test identification
- Coverage trends over time
- Defect detection effectiveness

## Test Results Analysis:

### Failure Analysis
- Categorize failures by type and cause
- Identify patterns in test failures
- Track failure rates over time
- Generate actionable failure reports

### Coverage Analysis
- Line, branch, and function coverage
- Coverage trends and improvements
- Uncovered code identification
- Coverage delta from previous runs

### Performance Analysis
- Test execution time trends
- Slowest tests identification
- Performance regression detection
- Resource usage optimization opportunities

## Reporting Format:

### Summary Report
- Overall test results summary
- Pass/fail rates by test suite
- Coverage statistics
- Key performance indicators

### Detailed Report
- Individual test results
- Failure details with stack traces
- Coverage reports with line-by-line analysis
- Performance metrics and trends

### Dashboard Integration
- Real-time test results dashboard
- Historical trend analysis
- Test quality metrics
- Automated alerting for failures

## Output:

The command will create:
- `test-results/results-[timestamp].xml`: JUnit XML results
- `test-results/coverage-[timestamp].html`: Coverage report
- `test-results/performance-[timestamp].json`: Performance metrics
- `test-results/failures-[timestamp].md`: Failure analysis report

## Example Usage:

```bash
# Run all tests with coverage
/qa:run all local --parallel --coverage --report

# Run specific test suite
/qa:run integration staging --retry 3

# Run smoke tests for production deployment
/qa:run smoke production --timeout 300
```

!echo "Executing test suite: $ARGUMENTS"
!mkdir -p test-results