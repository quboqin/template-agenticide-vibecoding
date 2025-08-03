#!/bin/bash

# Pre-push hook for Claude Code AI Development Workflow
# Runs integration tests, security scans, and build verification

set -e

echo "🚀 Running pre-push checks..."

# Get branch information
BRANCH=$(git rev-parse --abbrev-ref HEAD)
REMOTE_BRANCH=$(git rev-parse --abbrev-ref @{u} 2>/dev/null || echo "origin/$BRANCH")

echo "📋 Branch: $BRANCH"
echo "📋 Remote: $REMOTE_BRANCH"

# Check if pushing to protected branches
if [[ "$BRANCH" == "main" || "$BRANCH" == "master" || "$BRANCH" == "develop" ]]; then
    echo "🔒 Pushing to protected branch: $BRANCH"
    echo "Running comprehensive checks..."
    
    # Ensure all tests pass
    echo "🧪 Running full test suite..."
    if [ -f "package.json" ] && grep -q "test" package.json; then
        npm test || {
            echo "❌ Tests failed - push blocked"
            exit 1
        }
    elif [ -f "requirements.txt" ] && command -v pytest >/dev/null 2>&1; then
        pytest || {
            echo "❌ Tests failed - push blocked"
            exit 1
        }
    fi
    
    # Build verification
    echo "🏗️ Verifying build..."
    if [ -f "package.json" ] && grep -q "build" package.json; then
        npm run build || {
            echo "❌ Build failed - push blocked"
            exit 1
        }
    fi
fi

# Security dependency check
echo "🔐 Checking dependencies for vulnerabilities..."
if [ -f "package.json" ] && command -v npm >/dev/null 2>&1; then
    # Check for npm audit
    if npm audit --audit-level=high 2>/dev/null; then
        echo "✅ No high-severity vulnerabilities found"
    else
        echo "⚠️ Warning: High-severity vulnerabilities detected"
        echo "Consider running 'npm audit fix' to resolve issues"
    fi
elif [ -f "requirements.txt" ] && command -v safety >/dev/null 2>&1; then
    safety check || echo "⚠️ Warning: Python dependency vulnerabilities detected"
fi

# Check for TODO/FIXME in committed code
echo "📝 Checking for TODO/FIXME items..."
TODO_COUNT=$(git diff origin/$BRANCH..HEAD --name-only | xargs grep -l "TODO\|FIXME" 2>/dev/null | wc -l || echo 0)
if [ "$TODO_COUNT" -gt 0 ]; then
    echo "⚠️ Warning: $TODO_COUNT files contain TODO/FIXME items"
    echo "Consider addressing these before pushing to main branches"
fi

# Check commit message quality for main branches
if [[ "$BRANCH" == "main" || "$BRANCH" == "master" ]]; then
    echo "📝 Checking commit message quality..."
    LAST_COMMIT_MSG=$(git log -1 --pretty=%B)
    
    # Check for conventional commit format
    if ! echo "$LAST_COMMIT_MSG" | grep -qE "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+"; then
        echo "⚠️ Warning: Commit message doesn't follow conventional commit format"
        echo "Consider using format: type(scope): description"
    fi
fi

# Performance check for large commits
COMMIT_COUNT=$(git rev-list --count origin/$BRANCH..HEAD 2>/dev/null || echo 1)
if [ "$COMMIT_COUNT" -gt 10 ]; then
    echo "⚠️ Warning: Pushing $COMMIT_COUNT commits at once"
    echo "Consider smaller, more frequent pushes for better collaboration"
fi

# Check for merge conflicts
echo "🔀 Checking for merge conflicts..."
if git diff --check HEAD~1; then
    echo "✅ No merge conflict markers found"
else
    echo "❌ Merge conflict markers detected - push blocked"
    exit 1
fi

echo "✅ Pre-push checks completed successfully!"
echo "🚀 Pushing to $REMOTE_BRANCH"