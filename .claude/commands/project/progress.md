---
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash(git log:*)", "TodoWrite"]
description: "Track and analyze project progress with detailed reporting"
usage: "/project:progress [scope] [--dashboard] [--trends] [--forecast]"
---

# Project Progress Tracker

Analyze project progress and generate comprehensive status reports for $ARGUMENTS with trend analysis and forecasting.

## Progress Analysis:

1. **Current Status Assessment**
   - Analyze completed vs planned tasks
   - Calculate milestone completion rates
   - Assess quality metrics and KPIs

2. **Velocity Analysis**
   - Track team velocity trends
   - Identify productivity patterns
   - Analyze sprint/iteration performance

3. **Risk and Blocker Assessment**
   - Identify current blockers and risks
   - Assess impact on timeline and deliverables
   - Recommend mitigation strategies

4. **Forecasting**
   - Predict completion dates based on current velocity
   - Analyze resource requirements
   - Forecast budget and timeline adjustments

## Scope Options:

- `overall`: Complete project progress analysis
- `team`: Team-specific progress and performance
- `milestones`: Milestone-focused progress tracking
- `quality`: Quality metrics and technical debt analysis
- `risks`: Risk assessment and mitigation tracking

## Options:

- `--dashboard`: Generate visual progress dashboard
- `--trends`: Include trend analysis and patterns
- `--forecast`: Add completion forecasts and projections
- `--detailed`: Include detailed task-level analysis

## Progress Metrics:

### Completion Metrics
- Task completion rate (planned vs actual)
- Milestone achievement rate
- Sprint/iteration completion rate
- Quality gate pass rate

### Velocity Metrics
- Story points completed per sprint
- Tasks completed per day/week
- Code commits and reviews per developer
- Bug fix rate and response time

### Quality Metrics
- Code coverage percentage
- Defect density and severity distribution
- Technical debt accumulation
- Code review findings and resolution

### Team Performance
- Individual productivity metrics
- Collaboration effectiveness
- Knowledge sharing indicators
- Team satisfaction scores

## Reporting Format:

### Executive Summary
- Overall project health status
- Key achievements and milestones
- Critical issues and risks
- Recommended actions

### Detailed Analysis
- Velocity trends and patterns
- Quality metrics analysis
- Resource utilization
- Timeline and budget status

### Forecasting
- Completion date predictions
- Resource requirement projections
- Risk impact scenarios
- Recommended adjustments

## Output:

The command will create:
- `reports/progress-report-[date].md`: Comprehensive progress report
- `reports/velocity-analysis.md`: Team velocity analysis
- `reports/risk-assessment.md`: Current risks and mitigation plans
- Update PROJECT_PROGRESS.md with latest status

## Example Usage:

```bash
# Overall project progress
/project:progress overall --dashboard --trends

# Team performance analysis
/project:progress team --detailed

# Milestone tracking with forecasting
/project:progress milestones --forecast
```

!echo "Generating progress report for: $ARGUMENTS"
!mkdir -p reports
!git log --oneline -10