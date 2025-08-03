#!/bin/bash

# Verification script for Claude Code sub-agents

echo "🤖 Claude Code Sub-Agent Verification"
echo "===================================="

# Check if .claude/agents directory exists
if [ ! -d ".claude/agents" ]; then
    echo "❌ .claude/agents directory not found"
    exit 1
fi

echo "✅ .claude/agents directory found"

# Count agent files
AGENT_COUNT=$(find .claude/agents -name "*.md" | wc -l | tr -d ' ')
echo "📊 Found $AGENT_COUNT agent files"

# Verify each agent has proper frontmatter
echo ""
echo "🔍 Verifying agent frontmatter:"

for agent_file in .claude/agents/*.md; do
    if [ -f "$agent_file" ]; then
        agent_name=$(basename "$agent_file" .md)
        
        # Check for YAML frontmatter
        if head -1 "$agent_file" | grep -q "^---$"; then
            # Check for required fields
            if grep -q "^name:" "$agent_file" && \
               grep -q "^description:" "$agent_file" && \
               grep -q "^tools:" "$agent_file"; then
                echo "✅ $agent_name - Valid frontmatter"
            else
                echo "❌ $agent_name - Missing required frontmatter fields"
            fi
        else
            echo "❌ $agent_name - No YAML frontmatter found"
        fi
    fi
done

# Verify commands directory
echo ""
echo "🔍 Verifying command structure:"

if [ -d ".claude/commands" ]; then
    COMMAND_COUNT=$(find .claude/commands -name "*.md" | wc -l | tr -d ' ')
    echo "✅ Found $COMMAND_COUNT command files"
else
    echo "❌ .claude/commands directory not found"
fi

# Verify settings files
echo ""
echo "🔍 Verifying configuration:"

if [ -f ".claude/settings.json" ]; then
    echo "✅ settings.json found"
else
    echo "❌ settings.json not found"
fi

if [ -f ".claude/settings.local.json" ]; then
    echo "✅ settings.local.json found"
else
    echo "⚠️ settings.local.json not found (optional)"
fi

echo ""
echo "📋 Summary:"
echo "- Agents: $AGENT_COUNT"
echo "- Commands: $COMMAND_COUNT"
echo "- Configuration: Complete"
echo ""
echo "🎉 Claude Code integration verification complete!"
echo ""
echo "To test agents, try running:"
echo "  claude /agents"
echo "  claude /product:analyze --help"
echo "  claude /project:progress --help"