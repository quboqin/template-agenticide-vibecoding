---
allowed-tools: ["Read", "Write", "Edit", "Bash(mkdir:*)", "Bash(git:*)", "TodoWrite", "Glob"]
description: "Initialize new project with proper structure and configuration"
usage: "/project:init [project-name] [type] [--timeline] [--team-size] [--framework]"
---

# Project Initialization Engine

Initialize a new project with proper structure, configuration, and team setup for $ARGUMENTS.

## Initialization Process:

1. **Project Setup**
   - Create project directory structure
   - Initialize version control system
   - Setup basic configuration files

2. **Team Configuration**
   - Define team roles and responsibilities
   - Setup collaboration workflows
   - Configure communication channels

3. **Development Environment**
   - Setup development tools and dependencies
   - Configure build and deployment pipelines
   - Initialize testing framework

4. **Project Management**
   - Create project charter and scope
   - Setup milestone and timeline tracking
   - Initialize risk register

## Project Types:

- `product`: Full product development project
- `feature`: Feature development project  
- `infrastructure`: Infrastructure/platform project
- `research`: Research and development project
- `maintenance`: Maintenance and optimization project

## Options:

- `--timeline [duration]`: Set project timeline (e.g., 3-months, 6-months)
- `--team-size [number]`: Define team size and structure
- `--framework [name]`: Specify technology framework
- `--methodology [type]`: Choose methodology (agile, waterfall, hybrid)

## Project Structure:

```
[project-name]/
├── .claude/                 # Claude Code configuration
├── docs/                    # Project documentation
├── specs/                   # Technical specifications
├── src/                     # Source code
├── tests/                   # Test files
├── scripts/                 # Build and deployment scripts
├── .gitignore              # Git ignore rules
├── README.md               # Project overview
├── PROJECT_CHARTER.md      # Project charter
└── ROADMAP.md              # Project roadmap
```

## Configuration Files:

### Project Charter
- Project objectives and scope
- Success criteria and KPIs
- Stakeholder identification
- Risk assessment

### Development Setup
- Technology stack definition
- Development environment configuration
- Code quality standards
- Testing strategy

### Team Structure
- Role definitions and responsibilities
- Communication protocols
- Workflow and process definitions
- Collaboration tools setup

## Output:

The command will create:
- Complete project directory structure
- Initial configuration files
- Project charter and documentation
- Team setup and workflow definitions
- Initial roadmap and milestone planning

## Example Usage:

```bash
# Initialize product project
/project:init ai-chatbot product --timeline 6-months --team-size 8

# Initialize feature project
/project:init user-dashboard feature --framework react

# Initialize infrastructure project
/project:init ci-cd-pipeline infrastructure --methodology agile
```

!echo "Initializing project: $ARGUMENTS"
!git status