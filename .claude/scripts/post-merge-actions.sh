#!/bin/bash

# Post-merge hook for Claude Code AI Development Workflow
# Runs after successful merge operations

set -e

echo "🔄 Running post-merge actions..."

# Get merge information
BRANCH=$(git rev-parse --abbrev-ref HEAD)
MERGE_HEAD=$(git rev-parse --verify MERGE_HEAD 2>/dev/null || echo "")

echo "📋 Current branch: $BRANCH"

# Update dependencies if package files changed
echo "📦 Checking for dependency updates..."

# Check if package.json changed
if git diff-tree -r --name-only HEAD~1 HEAD | grep -q "package.json"; then
    echo "📦 package.json changed, updating dependencies..."
    if command -v npm >/dev/null 2>&1; then
        npm install || echo "⚠️ Warning: npm install failed"
    fi
fi

# Check if requirements.txt changed
if git diff-tree -r --name-only HEAD~1 HEAD | grep -q "requirements.txt"; then
    echo "🐍 requirements.txt changed, updating Python dependencies..."
    if command -v pip >/dev/null 2>&1; then
        pip install -r requirements.txt || echo "⚠️ Warning: pip install failed"
    fi
fi

# Check if Gemfile changed
if git diff-tree -r --name-only HEAD~1 HEAD | grep -q "Gemfile"; then
    echo "💎 Gemfile changed, updating Ruby dependencies..."
    if command -v bundle >/dev/null 2>&1; then
        bundle install || echo "⚠️ Warning: bundle install failed"
    fi
fi

# Run database migrations if they exist and changed
echo "🗄️ Checking for database migrations..."
if git diff-tree -r --name-only HEAD~1 HEAD | grep -q "migrations\|migrate"; then
    echo "🗄️ Database migrations detected..."
    
    # Django migrations
    if [ -f "manage.py" ]; then
        echo "Running Django migrations..."
        python manage.py migrate || echo "⚠️ Warning: Django migrations failed"
    fi
    
    # Rails migrations
    if [ -f "Rakefile" ] && grep -q "rails" Rakefile; then
        echo "Running Rails migrations..."
        bundle exec rake db:migrate || echo "⚠️ Warning: Rails migrations failed"
    fi
fi

# Update project documentation
echo "📚 Updating project documentation..."

# Regenerate API documentation if it exists
if [ -f "docs/generate.sh" ]; then
    echo "Regenerating API documentation..."
    cd docs && ./generate.sh && cd .. || echo "⚠️ Warning: Documentation generation failed"
fi

# Update changelog if using conventional commits
if command -v conventional-changelog >/dev/null 2>&1; then
    echo "Updating changelog..."
    conventional-changelog -p angular -i CHANGELOG.md -s || echo "⚠️ Warning: Changelog update failed"
fi

# Run quick smoke tests after merge
echo "💨 Running smoke tests..."
if [ -f "package.json" ] && grep -q "test:smoke" package.json; then
    npm run test:smoke || echo "⚠️ Warning: Smoke tests failed"
elif [ -f "Makefile" ] && grep -q "smoke" Makefile; then
    make smoke || echo "⚠️ Warning: Smoke tests failed"
fi

# Clean up old artifacts
echo "🧹 Cleaning up..."

# Clean npm cache if node_modules size is large
if [ -d "node_modules" ]; then
    NODE_MODULES_SIZE=$(du -sm node_modules 2>/dev/null | cut -f1)
    if [ "$NODE_MODULES_SIZE" -gt 500 ]; then  # 500MB
        echo "🧹 Large node_modules detected, consider cleaning..."
        echo "Run 'npm prune' or 'rm -rf node_modules && npm install' to clean up"
    fi
fi

# Update development environment status
echo "📊 Updating development status..."

# Update project progress file if it exists
if [ -f "PROJECT_PROGRESS.md" ]; then
    echo "Updating PROJECT_PROGRESS.md..."
    echo "" >> PROJECT_PROGRESS.md
    echo "## Merge completed: $(date)" >> PROJECT_PROGRESS.md
    echo "Branch: $BRANCH" >> PROJECT_PROGRESS.md
    echo "Changes:" >> PROJECT_PROGRESS.md
    git diff-tree -r --name-only HEAD~1 HEAD | head -10 | sed 's/^/- /' >> PROJECT_PROGRESS.md
    
    if [ $(git diff-tree -r --name-only HEAD~1 HEAD | wc -l) -gt 10 ]; then
        echo "- ... and $(( $(git diff-tree -r --name-only HEAD~1 HEAD | wc -l) - 10 )) more files" >> PROJECT_PROGRESS.md
    fi
fi

# Notify about successful merge (if notification tools are available)
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Git Merge" "Post-merge actions completed successfully on $BRANCH"
elif command -v osascript >/dev/null 2>&1; then
    osascript -e "display notification \"Post-merge actions completed successfully on $BRANCH\" with title \"Git Merge\""
fi

echo "✅ Post-merge actions completed successfully!"
echo "🎉 Ready for development on $BRANCH"