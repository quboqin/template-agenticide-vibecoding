---
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "TodoWrite"]
description: "Create comprehensive Product Requirements Document"
usage: "/product:prd [feature] [priority] [--stakeholders] [--metrics] [--timeline]"
---

# Product Requirements Document Generator

Create a comprehensive Product Requirements Document (PRD) for $ARGUMENTS with detailed specifications, user stories, and success metrics.

## PRD Creation Process:

1. **Requirements Gathering**
   - Analyze business objectives and goals
   - Identify user needs and pain points
   - Define feature scope and boundaries

2. **Stakeholder Analysis**
   - Identify all stakeholders and their interests
   - Define roles and responsibilities
   - Establish communication and approval processes

3. **Feature Definition**
   - Write detailed user stories
   - Define acceptance criteria
   - Specify functional and non-functional requirements

4. **Success Metrics**
   - Define KPIs and success metrics
   - Establish measurement methodology
   - Set performance benchmarks

## Options:

- `--stakeholders`: Include detailed stakeholder analysis
- `--metrics`: Focus on KPIs and success metrics definition
- `--timeline`: Include detailed timeline and milestones
- `--technical`: Add technical requirements section

## PRD Structure:

### Executive Summary
- Feature overview and business justification
- Key stakeholders and decision makers
- Success criteria and metrics

### Problem Statement
- User problems and pain points
- Business opportunity and market need
- Current solution limitations

### Solution Overview
- Proposed solution description
- Key features and capabilities
- User experience flow

### Requirements
- Functional requirements
- Non-functional requirements
- Technical requirements
- Security and compliance requirements

### User Stories
- Epic-level user stories
- Detailed user stories with acceptance criteria
- User journey mapping

### Success Metrics
- Key Performance Indicators (KPIs)
- Success criteria and benchmarks
- Measurement methodology

### Implementation Plan
- Development phases and milestones
- Resource requirements
- Risk assessment and mitigation

## Output:

The command will create:
- `prd/[feature]-prd.md`: Main PRD document
- `prd/[feature]-user-stories.md`: Detailed user stories
- `prd/[feature]-metrics.md`: Success metrics and KPIs
- Update project roadmap and todo list

## Example Usage:

```bash
# Create comprehensive PRD
/product:prd user-onboarding high --stakeholders --metrics

# Quick PRD for small feature
/product:prd search-filters medium

# PRD with timeline focus
/product:prd payment-integration critical --timeline --technical
```

!echo "Creating PRD for: $ARGUMENTS"
!mkdir -p prd