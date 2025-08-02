#!/bin/bash

# GitHub仓库设置脚本
# 使用方法: ./setup-github.sh your-github-username

if [ $# -eq 0 ]; then
    echo "请提供您的GitHub用户名"
    echo "用法: ./setup-github.sh your-github-username"
    exit 1
fi

GITHUB_USERNAME=$1
REPO_NAME="template-agenticide-vibecoding"

echo "🚀 设置GitHub仓库..."
echo "用户名: $GITHUB_USERNAME"
echo "仓库名: $REPO_NAME"

# 添加远程仓库
git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git

# 设置上游分支并推送
git branch -M main
git push -u origin main

echo "✅ GitHub仓库设置完成！"
echo "📍 仓库地址: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""
echo "🎯 下一步:"
echo "1. 访问仓库页面设置描述和标签"
echo "2. 启用Issues和Discussions"
echo "3. 设置分支保护规则"
echo "4. 添加仓库主题: ai, claude-code, development-workflow, automation"