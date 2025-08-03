---
allowed-tools: ["Read", "Bash(git diff:*)", "Bash(git log:*)", "Grep", "Glob", "Write", "TodoWrite"]
description: "Comprehensive code review with quality, security, and performance analysis"
usage: "/review [scope] [--focus] [--automated] [--checklist]"
---

# Code Review and Quality Analysis

Perform comprehensive code review for $ARGUMENTS with automated analysis, security scanning, and quality assessment.

## Review Process:

1. **Code Analysis**
   - Analyze code changes and structure
   - Check adherence to coding standards
   - Identify potential issues and improvements

2. **Security Assessment**
   - Scan for security vulnerabilities
   - Check for sensitive data exposure
   - Validate input sanitization and validation

3. **Performance Analysis**
   - Identify performance bottlenecks
   - Analyze algorithmic complexity
   - Check for resource leaks and optimization opportunities

4. **Architecture Review**
   - Assess architectural patterns and principles
   - Check for proper separation of concerns
   - Validate design patterns implementation

## Review Scope:

- `staged`: Review staged changes only
- `branch`: Review entire feature branch
- `[directory]`: Review specific directory/module
- `[file]`: Review specific file
- `.`: Review entire codebase

## Focus Areas:

- `security`: Focus on security vulnerabilities and best practices
- `performance`: Focus on performance optimization opportunities
- `maintainability`: Focus on code maintainability and readability
- `architecture`: Focus on architectural patterns and structure
- `all`: Comprehensive review of all aspects

## Options:

- `--focus [area]`: Focus on specific review area
- `--automated`: Run automated analysis tools
- `--checklist`: Generate review checklist
- `--detailed`: Include detailed explanations and examples

## Review Checklist:

### Code Quality
- [ ] Code follows established style guidelines
- [ ] Functions and classes have single responsibility
- [ ] Code is properly documented with comments
- [ ] Error handling is comprehensive and appropriate
- [ ] No code duplication or redundancy

### Security
- [ ] Input validation and sanitization
- [ ] No hardcoded secrets or credentials
- [ ] Proper authentication and authorization
- [ ] SQL injection prevention
- [ ] XSS and CSRF protection

### Performance
- [ ] Efficient algorithms and data structures
- [ ] Proper memory management
- [ ] Database queries are optimized
- [ ] Caching strategies implemented where appropriate
- [ ] No unnecessary loops or computations

### Testing
- [ ] Unit tests cover critical functionality
- [ ] Integration tests validate component interactions
- [ ] Edge cases are properly tested
- [ ] Test code is maintainable and readable
- [ ] Test coverage meets project standards

### Documentation
- [ ] API documentation is up to date
- [ ] Code comments explain complex logic
- [ ] README files are comprehensive
- [ ] Changelog is updated with changes

## Automated Analysis Tools:

### Static Analysis
- ESLint/Pylint for code quality
- SonarQube for code coverage and complexity
- CodeQL for security vulnerability detection
- Prettier/Black for code formatting

### Security Scanning
- Snyk for dependency vulnerabilities
- Bandit for Python security issues
- ESLint security plugin for JavaScript
- OWASP ZAP for web application security

### Performance Analysis
- Lighthouse for web performance
- Memory profilers for memory leak detection
- Load testing tools for stress testing
- Database query analyzers

## Output:

The command will create:
- `reviews/review-[date]-[scope].md`: Detailed review report
- `reviews/issues-[date].md`: Issues and recommendations
- `reviews/security-scan-[date].md`: Security analysis report
- Update todo list with identified action items

## Review Report Structure:

### Executive Summary
- Overall code quality score
- Critical issues found
- Recommended priority actions
- Security risk assessment

### Detailed Findings
- Code quality issues with examples
- Security vulnerabilities with severity
- Performance optimization opportunities
- Architecture improvement suggestions

### Recommendations
- Immediate action items
- Long-term improvement suggestions
- Tool and process recommendations
- Training and knowledge sharing needs

## Example Usage:

```bash
# Review staged changes with automated analysis
/review staged --automated --focus security

# Comprehensive codebase review
/review . --detailed --checklist

# Review specific component for performance
/review src/components/UserDashboard --focus performance
```

!echo "Starting code review for: $ARGUMENTS"
!git diff --stat