---
allowed-tools: ["Read", "Write", "Grep", "Glob", "Bash(git log:*)", "TodoWrite"]
description: "Generate comprehensive quality assurance reports and metrics"
usage: "/qa:report [type] [period] [--format] [--stakeholders]"
---

# Quality Assurance Reporting Engine

Generate comprehensive QA reports for $ARGUMENTS with metrics analysis, trend identification, and actionable insights.

## Report Generation Process:

1. **Data Collection**
   - Gather test execution results
   - Collect code coverage metrics
   - Analyze defect tracking data
   - Review quality gate compliance

2. **Metrics Analysis**
   - Calculate quality KPIs and trends
   - Identify patterns and anomalies
   - Compare against quality targets
   - Assess improvement opportunities

3. **Report Generation**
   - Create stakeholder-specific reports
   - Generate visual dashboards and charts
   - Include actionable recommendations
   - Provide historical trend analysis

4. **Distribution**
   - Share reports with relevant stakeholders
   - Update quality dashboards
   - Archive reports for future reference
   - Schedule automated report delivery

## Report Types:

- `quality`: Overall quality assessment report
- `coverage`: Code coverage analysis report
- `performance`: Performance testing report
- `security`: Security testing and vulnerability report
- `defects`: Defect analysis and trend report
- `compliance`: Compliance and audit report
- `release`: Release readiness assessment

## Report Periods:

- `daily`: Daily quality metrics snapshot
- `weekly`: Weekly quality summary
- `sprint`: Sprint/iteration quality report
- `monthly`: Monthly quality trend analysis
- `quarterly`: Quarterly quality review
- `release`: Release-specific quality report

## Options:

- `--format [html|pdf|json|csv]`: Report output format
- `--stakeholders [team|management|executives]`: Target audience
- `--detailed`: Include detailed analysis and drill-down data
- `--trends`: Include historical trend analysis
- `--recommendations`: Include improvement recommendations

## Quality Metrics:

### Test Metrics
- Test pass/fail rates
- Test coverage percentages
- Test execution time trends
- Flaky test identification
- Test automation coverage

### Defect Metrics
- Defect discovery rate
- Defect resolution time
- Defect severity distribution
- Escaped defects analysis
- Root cause analysis

### Code Quality Metrics
- Code complexity metrics
- Technical debt assessment
- Code review findings
- Static analysis results
- Security vulnerability counts

### Process Metrics
- Quality gate compliance
- Release cycle time
- Deployment frequency
- Mean time to recovery (MTTR)
- Change failure rate

## Report Structure:

### Executive Summary
- Overall quality health score
- Key achievements and improvements
- Critical issues and risks
- Recommended actions

### Quality Metrics Dashboard
- Visual representation of key metrics
- Trend charts and comparisons
- Target vs actual performance
- Quality gate status

### Detailed Analysis
- Test execution results breakdown
- Coverage analysis with gaps
- Defect analysis with categorization
- Performance and security findings

### Recommendations
- Immediate action items
- Process improvement suggestions
- Tool and automation opportunities
- Training and skill development needs

### Appendices
- Raw data and detailed metrics
- Test result details
- Historical trend data
- Glossary of terms and metrics

## Visualization Elements:

### Charts and Graphs
- Test pass/fail trend lines
- Coverage heat maps
- Defect severity pie charts
- Performance benchmark comparisons

### Dashboards
- Real-time quality metrics
- Historical trend analysis
- Comparative analysis across releases
- Drill-down capabilities for detailed investigation

### Risk Assessment
- Quality risk matrix
- Impact vs probability analysis
- Risk mitigation tracking
- Quality prediction models

## Stakeholder-Specific Reports:

### Development Team
- Detailed test results and failures
- Code coverage gaps and improvements
- Technical debt and code quality issues
- Performance optimization opportunities

### Management
- Quality KPI summary and trends
- Risk assessment and mitigation plans
- Resource allocation recommendations
- Process improvement initiatives

### Executives
- Quality health score and trends
- Business impact of quality issues
- Cost of quality analysis
- Strategic quality initiatives

## Output:

The command will create:
- `reports/qa-report-[type]-[date].[format]`: Main report file
- `reports/metrics-[date].json`: Raw metrics data
- `reports/dashboard-[date].html`: Interactive dashboard
- `reports/recommendations-[date].md`: Improvement recommendations

## Example Usage:

```bash
# Generate weekly quality report for management
/qa:report quality weekly --format html --stakeholders management

# Create detailed coverage report
/qa:report coverage sprint --detailed --trends

# Generate executive summary for quarterly review
/qa:report quality quarterly --format pdf --stakeholders executives
```

!echo "Generating QA report: $ARGUMENTS"
!mkdir -p reports/qa