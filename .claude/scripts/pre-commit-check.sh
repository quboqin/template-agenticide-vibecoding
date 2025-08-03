#!/bin/bash

# Pre-commit hook for Claude Code AI Development Workflow
# Runs code quality checks, security scans, and basic tests

set -e

echo "🔍 Running pre-commit checks..."

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not in a git repository"
    exit 1
fi

# Get list of staged files
STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACMR)

if [ -z "$STAGED_FILES" ]; then
    echo "ℹ️ No staged files to check"
    exit 0
fi

echo "📋 Checking staged files:"
echo "$STAGED_FILES"

# Check for secrets and sensitive information
echo "🔐 Checking for secrets..."
if echo "$STAGED_FILES" | grep -E "\.(js|ts|py|json|yaml|yml|env)$" | xargs grep -l -E "(password|secret|key|token|api_key)" 2>/dev/null; then
    echo "⚠️ Warning: Potential secrets found in staged files"
    echo "Please review and remove any sensitive information before committing"
fi

# Check for large files
echo "📏 Checking file sizes..."
for file in $STAGED_FILES; do
    if [ -f "$file" ]; then
        size=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
        if [ "$size" -gt 1048576 ]; then  # 1MB
            echo "⚠️ Warning: Large file detected: $file ($(($size / 1024))KB)"
        fi
    fi
done

# Run linting for supported file types
echo "🔧 Running linters..."

# JavaScript/TypeScript files
JS_TS_FILES=$(echo "$STAGED_FILES" | grep -E "\.(js|ts|jsx|tsx)$" || true)
if [ -n "$JS_TS_FILES" ] && command -v npx >/dev/null 2>&1; then
    if [ -f "package.json" ] && grep -q "eslint" package.json; then
        echo "Running ESLint..."
        echo "$JS_TS_FILES" | xargs npx eslint --fix || true
    fi
fi

# Python files
PY_FILES=$(echo "$STAGED_FILES" | grep -E "\.py$" || true)
if [ -n "$PY_FILES" ]; then
    if command -v flake8 >/dev/null 2>&1; then
        echo "Running flake8..."
        echo "$PY_FILES" | xargs flake8 || true
    fi
    if command -v black >/dev/null 2>&1; then
        echo "Running black..."
        echo "$PY_FILES" | xargs black --check || true
    fi
fi

# Check for Claude Code command syntax
echo "⚙️ Validating Claude Code commands..."
COMMAND_FILES=$(echo "$STAGED_FILES" | grep -E "\.claude/commands/.*\.md$" || true)
if [ -n "$COMMAND_FILES" ]; then
    for file in $COMMAND_FILES; do
        if [ -f "$file" ]; then
            # Check for required frontmatter
            if ! head -5 "$file" | grep -q "^---$"; then
                echo "❌ Missing frontmatter in command file: $file"
                exit 1
            fi
            
            # Check for required fields
            if ! grep -q "allowed-tools:" "$file"; then
                echo "❌ Missing 'allowed-tools' in command file: $file"
                exit 1
            fi
            
            if ! grep -q "description:" "$file"; then
                echo "❌ Missing 'description' in command file: $file"
                exit 1
            fi
        fi
    done
fi

# Run unit tests if they exist
echo "🧪 Running unit tests..."
if [ -f "package.json" ] && grep -q "test" package.json && command -v npm >/dev/null 2>&1; then
    npm test -- --passWithNoTests --bail || {
        echo "❌ Unit tests failed"
        exit 1
    }
elif [ -f "requirements.txt" ] && command -v pytest >/dev/null 2>&1; then
    pytest --tb=short -x || {
        echo "❌ Unit tests failed"
        exit 1
    }
fi

# Add modified files back to staging area (for auto-fixes)
git add $STAGED_FILES

echo "✅ Pre-commit checks completed successfully!"
echo "🚀 Ready to commit"