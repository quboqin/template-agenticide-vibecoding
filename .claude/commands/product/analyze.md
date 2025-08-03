---
allowed-tools: ["Read", "Write", "WebFetch", "Grep", "Glob", "TodoWrite"]
description: "Comprehensive product and market analysis"
usage: "/product:analyze [domain] [--competitors] [--trends] [--opportunities]"
---

# Product Analysis Engine

Perform comprehensive product and market analysis for $ARGUMENTS with competitive intelligence, trend analysis, and opportunity identification.

## Analysis Process:

1. **Market Research**
   - Analyze target market size and segments
   - Identify key market trends and drivers
   - Research regulatory and compliance requirements

2. **Competitive Analysis**
   - Identify direct and indirect competitors
   - Analyze competitor strengths and weaknesses
   - Map competitive landscape and positioning

3. **Opportunity Assessment**
   - Identify market gaps and opportunities
   - Assess product-market fit potential
   - Analyze growth opportunities and risks

4. **User Research**
   - Define target user personas
   - Analyze user needs and pain points
   - Map user journey and touchpoints

## Options:

- `--competitors`: Include detailed competitive analysis
- `--trends`: Focus on market trends and future outlook
- `--opportunities`: Emphasize opportunity identification
- `--users`: Include user research and persona development

## Output:

The command will create:
- `analysis/market-analysis-[domain].md`: Comprehensive market analysis
- `analysis/competitive-landscape.md`: Competitive analysis report
- `analysis/user-personas.md`: User research and personas
- `analysis/opportunities.md`: Identified opportunities and recommendations

## Analysis Framework:

### Market Analysis
- Total Addressable Market (TAM)
- Serviceable Addressable Market (SAM)  
- Serviceable Obtainable Market (SOM)
- Market growth rates and trends

### Competitive Analysis
- Direct competitors analysis
- Indirect competitors analysis
- Feature comparison matrix
- Pricing analysis
- Market positioning map

### Opportunity Assessment
- Gap analysis
- SWOT analysis
- Risk assessment
- Growth opportunity evaluation

## Example Usage:

```bash
# Comprehensive market analysis
/product:analyze ai-development-tools --competitors --trends

# Focus on opportunities
/product:analyze mobile-app-market --opportunities

# User-centric analysis
/product:analyze e-commerce-platform --users --trends
```

!echo "Starting product analysis for: $ARGUMENTS"
!mkdir -p analysis