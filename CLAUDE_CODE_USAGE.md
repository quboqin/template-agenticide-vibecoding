# Claude Code AI Development Workflow - Usage Guide

## 🚀 Quick Start

This project provides a complete Claude Code extension with specialized AI agents and commands for professional software development workflows.

### Prerequisites
- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and configured
- Git repository initialized
- Node.js 18+ or Python 3.8+ (depending on your project)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/quboqin/template-agenticide-vibecoding.git
   cd template-agenticide-vibecoding
   ```

2. **Switch to the Claude Code integration branch:**
   ```bash
   git checkout claude-code-integration
   ```

3. **Copy Claude Code configuration to your project:**
   ```bash
   # Copy the entire .claude directory to your project
   cp -r .claude /path/to/your/project/
   ```

4. **Verify installation:**
   ```bash
   cd /path/to/your/project
   claude --help
   ```

## 📋 Available Commands

### Project Management Commands

#### `/spec [component] [options]`
Create comprehensive technical specifications.
```bash
# Create basic specification
/spec user-authentication

# Create detailed specification with review checkpoints
/spec payment-system --detailed --review
```

#### `/product:analyze [domain] [options]`
Market and competitive analysis.
```bash
# Comprehensive market analysis
/product:analyze ai-development-tools --competitors --trends

# User-focused analysis
/product:analyze mobile-app --users --opportunities
```

#### `/product:prd [feature] [priority] [options]`
Create Product Requirements Documents.
```bash
# Create comprehensive PRD
/product:prd user-onboarding high --stakeholders --metrics

# Quick PRD for small feature
/product:prd search-filters medium
```

#### `/project:init [project-name] [type] [options]`
Initialize new projects with proper structure.
```bash
# Initialize product project
/project:init ai-chatbot product --timeline 6-months --team-size 8

# Initialize feature project
/project:init user-dashboard feature --framework react
```

#### `/project:progress [scope] [options]`
Track and analyze project progress.
```bash
# Overall project progress with dashboard
/project:progress overall --dashboard --trends

# Team performance analysis
/project:progress team --detailed
```

### Development Commands

#### `/implement [feature] [options]`
Implement features with TDD and best practices.
```bash
# Implement React component with TDD
/implement user-profile-card --type component --framework react --test-driven

# Implement API endpoint
/implement user-authentication --type api --framework fastapi --spec-driven
```

#### `/review [scope] [options]`
Comprehensive code review and quality analysis.
```bash
# Review staged changes with automated analysis
/review staged --automated --focus security

# Comprehensive codebase review
/review . --detailed --checklist
```

### Testing Commands

#### `/qa:create [type] [scope] [options]`
Create comprehensive test suites.
```bash
# Create unit tests with Jest
/qa:create unit src/components --framework jest --coverage 85%

# Create E2E tests with Playwright
/qa:create e2e user-authentication --framework playwright --data
```

#### `/qa:run [suite] [environment] [options]`
Execute test suites with reporting.
```bash
# Run all tests with coverage
/qa:run all local --parallel --coverage --report

# Run specific test suite
/qa:run integration staging --retry 3
```

#### `/qa:report [type] [period] [options]`
Generate QA reports and metrics.
```bash
# Generate weekly quality report
/qa:report quality weekly --format html --stakeholders management

# Create detailed coverage report
/qa:report coverage sprint --detailed --trends
```

### Deployment Commands

#### `/deploy:prep [environment] [strategy] [options]`
Prepare deployments with validation.
```bash
# Prepare production deployment with full validation
/deploy:prep production blue-green --validate --rollback --monitor

# Prepare staging deployment with dry run
/deploy:prep staging rolling --dry-run
```

#### `/deploy:monitor [service] [metrics] [options]`
Setup monitoring and observability.
```bash
# Setup comprehensive monitoring with alerts
/deploy:monitor user-service performance --alerts --dashboard

# Setup SLA monitoring
/deploy:monitor payment-api availability --sla --alerts
```

## 🤖 Specialized AI Agents

### Product Manager Agent
- **Focus**: Product strategy, market analysis, user research
- **Commands**: `/product:*`
- **Expertise**: PRD creation, competitive analysis, user personas

### Project Manager Agent
- **Focus**: Project execution, team coordination, risk management
- **Commands**: `/project:*`
- **Expertise**: Timeline management, resource allocation, progress tracking

### QA Specialist Agent
- **Focus**: Quality assurance, testing strategy, automation
- **Commands**: `/qa:*`
- **Expertise**: Test creation, execution, and quality reporting

### DevOps Engineer Agent
- **Focus**: Deployment, infrastructure, monitoring
- **Commands**: `/deploy:*`
- **Expertise**: CI/CD pipelines, container orchestration, observability

### Technical Architect Agent
- **Focus**: System design, code quality, technical strategy
- **Commands**: `/spec`, `/review`, `/implement`
- **Expertise**: Architecture patterns, performance optimization, technical debt management

### Security Engineer Agent
- **Focus**: Application security, compliance, threat modeling
- **Commands**: `/security:*` (when available)
- **Expertise**: Vulnerability assessment, secure coding, compliance

## 🔧 Configuration

### Settings Files

#### `.claude/settings.json` (Team Settings)
```json
{
  "permissions": {
    "allow": ["Bash(git:*)", "Read(*)", "Write(*)", "Edit(*)"]
  },
  "hooks": {
    "pre-commit": ".claude/scripts/pre-commit-check.sh",
    "pre-push": ".claude/scripts/pre-push-check.sh",
    "post-merge": ".claude/scripts/post-merge-actions.sh"
  },
  "ai_behavior": {
    "code_style": "clean_and_readable",
    "test_driven": true,
    "spec_driven": true,
    "security_first": true
  }
}
```

#### `.claude/settings.local.json` (Personal Settings)
```json
{
  "permissions": {
    "allow": ["Bash(npm:*)", "Bash(docker:*)"]
  }
}
```

### Hook System

The workflow includes automated hooks for quality assurance:

- **Pre-commit**: Code quality checks, security scans, unit tests
- **Pre-push**: Integration tests, build verification, dependency checks
- **Post-merge**: Dependency updates, documentation generation, smoke tests

## 🎯 Workflow Examples

### Complete Feature Development

1. **Create specification:**
   ```bash
   /spec user-authentication --detailed --review
   ```

2. **Create PRD:**
   ```bash
   /product:prd user-authentication high --stakeholders --metrics
   ```

3. **Initialize development:**
   ```bash
   /project:init auth-feature feature --framework react
   ```

4. **Implement with TDD:**
   ```bash
   /implement user-login --type component --framework react --test-driven
   ```

5. **Create comprehensive tests:**
   ```bash
   /qa:create e2e user-authentication --framework playwright
   ```

6. **Review implementation:**
   ```bash
   /review src/auth --focus security --automated
   ```

7. **Prepare deployment:**
   ```bash
   /deploy:prep staging rolling --validate
   ```

### Quality Assurance Workflow

1. **Create test strategy:**
   ```bash
   /qa:create unit src/ --framework jest --coverage 90%
   ```

2. **Execute test suites:**
   ```bash
   /qa:run all local --parallel --coverage --report
   ```

3. **Generate quality report:**
   ```bash
   /qa:report quality weekly --format html --detailed
   ```

4. **Review and improve:**
   ```bash
   /review . --focus quality --checklist
   ```

### Deployment Workflow

1. **Prepare deployment:**
   ```bash
   /deploy:prep production blue-green --validate --rollback
   ```

2. **Setup monitoring:**
   ```bash
   /deploy:monitor app-service performance --alerts --dashboard --sla
   ```

3. **Track progress:**
   ```bash
   /project:progress deployment --dashboard --trends
   ```

## 🔍 Best Practices

### Command Usage
- Use descriptive feature names and clear options
- Leverage the `--help` flag for detailed command information
- Combine commands for complete workflows
- Use appropriate agents for specialized tasks

### Quality Standards
- Always run tests before committing (`/qa:run`)
- Use code review commands for quality assurance (`/review`)
- Create specifications before implementation (`/spec`)
- Monitor deployments with proper observability (`/deploy:monitor`)

### Team Collaboration
- Use PRDs for feature alignment (`/product:prd`)
- Track progress transparently (`/project:progress`)
- Document architectural decisions (`/spec`)
- Share quality reports (`/qa:report`)

## 🆘 Troubleshooting

### Common Issues

1. **Command not found:**
   - Ensure `.claude/` directory is in your project root
   - Check that Claude Code is properly installed

2. **Permission denied:**
   - Review `.claude/settings.json` permissions
   - Ensure required tools are allowed

3. **Hook failures:**
   - Check hook script permissions (`chmod +x .claude/scripts/*.sh`)
   - Review hook output for specific errors

4. **Agent not responding correctly:**
   - Verify agent files exist in `.claude/agents/`
   - Check command syntax and options

### Getting Help

- Use `claude --help` for general help
- Use `/[command] --help` for command-specific help
- Check the [Claude Code documentation](https://docs.anthropic.com/en/docs/claude-code)
- Review agent-specific documentation in `.claude/agents/`

## 📚 Further Reading

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Command Reference](/.claude/commands/)
- [Agent Specifications](/.claude/agents/)
- [Hook System](/.claude/scripts/)
- [Project Progress](PROJECT_PROGRESS.md)