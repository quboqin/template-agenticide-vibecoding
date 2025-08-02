#!/bin/bash

# Git Worktree 多Agent并行开发管理脚本
# 支持Agent独立工作空间和并行开发

set -e

# 配置变量
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE_ROOT="${PROJECT_ROOT}/workspace"
MAIN_BRANCH="main"
DEVELOP_BRANCH="develop"

# Agent配置
declare -A AGENTS=(
    ["pm"]="PM Agent"
    ["architect"]="Architect Agent"
    ["frontend"]="Frontend Agent"
    ["backend"]="Backend Agent"
    ["devops"]="DevOps Agent"
    ["qa"]="QA Agent"
    ["security"]="Security Agent"
)

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 显示帮助信息
show_help() {
    cat << EOF
Git Worktree 多Agent并行开发管理工具

用法:
    $0 <command> [options]

命令:
    init                     初始化多Agent工作环境
    create-workspace <agent> <task>
                            为指定Agent创建任务工作空间
    list-workspaces         列出所有Agent工作空间
    sync-workspace <agent>  同步Agent工作空间
    merge-workspace <agent> <target_branch>
                            合并Agent工作空间到目标分支
    cleanup-workspace <agent>
                            清理Agent工作空间
    status                  显示所有Agent工作状态
    switch-workspace <agent> 切换到Agent工作空间
    
Agent类型:
    pm          项目管理
    architect   架构设计
    frontend    前端开发
    backend     后端开发
    devops      运维部署
    qa          质量保证
    security    安全审计

示例:
    $0 init
    $0 create-workspace frontend user-login-ui
    $0 create-workspace backend payment-api
    $0 list-workspaces
    $0 sync-workspace frontend
    $0 merge-workspace frontend develop
    $0 cleanup-workspace qa
    $0 status

EOF
}

# 检查Git仓库状态
check_git_repo() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        log_error "当前目录不是Git仓库"
        exit 1
    fi
}

# 检查分支是否存在
check_branch_exists() {
    local branch=$1
    if ! git show-ref --verify --quiet refs/heads/$branch; then
        return 1
    fi
    return 0
}

# 初始化多Agent工作环境
init_workspace() {
    log_info "初始化多Agent工作环境..."
    
    check_git_repo
    
    # 创建workspace目录
    mkdir -p "$WORKSPACE_ROOT"
    
    # 确保必要分支存在
    if ! check_branch_exists "$MAIN_BRANCH"; then
        log_warning "主分支 $MAIN_BRANCH 不存在，创建中..."
        git checkout -b "$MAIN_BRANCH"
    fi
    
    if ! check_branch_exists "$DEVELOP_BRANCH"; then
        log_warning "开发分支 $DEVELOP_BRANCH 不存在，创建中..."
        git checkout -b "$DEVELOP_BRANCH" "$MAIN_BRANCH"
    fi
    
    # 为每个Agent创建基础工作空间目录
    for agent in "${!AGENTS[@]}"; do
        agent_workspace="$WORKSPACE_ROOT/$agent"
        mkdir -p "$agent_workspace"
        log_info "创建 ${AGENTS[$agent]} 工作空间目录: $agent_workspace"
    done
    
    # 创建配置文件
    create_workspace_config
    
    log_success "多Agent工作环境初始化完成"
}

# 创建工作空间配置文件
create_workspace_config() {
    local config_file="$WORKSPACE_ROOT/.workspace-config"
    
    cat > "$config_file" << EOF
# Git Worktree 多Agent工作空间配置
MAIN_BRANCH=$MAIN_BRANCH
DEVELOP_BRANCH=$DEVELOP_BRANCH
PROJECT_ROOT=$PROJECT_ROOT
WORKSPACE_ROOT=$WORKSPACE_ROOT

# Agent配置
EOF
    
    for agent in "${!AGENTS[@]}"; do
        echo "AGENT_${agent^^}_NAME=\"${AGENTS[$agent]}\"" >> "$config_file"
    done
    
    log_info "工作空间配置文件创建: $config_file"
}

# 为Agent创建任务工作空间
create_agent_workspace() {
    local agent=$1
    local task=$2
    
    if [[ -z "$agent" || -z "$task" ]]; then
        log_error "请指定Agent和任务名称"
        show_help
        exit 1
    fi
    
    if [[ ! ${AGENTS[$agent]+_} ]]; then
        log_error "未知的Agent类型: $agent"
        log_info "可用Agent: ${!AGENTS[*]}"
        exit 1
    fi
    
    check_git_repo
    
    # 生成分支名称
    local branch_name="feature/${agent}/${task}"
    local workspace_path="$WORKSPACE_ROOT/$agent/$task"
    
    log_info "为 ${AGENTS[$agent]} 创建任务工作空间..."
    log_info "任务: $task"
    log_info "分支: $branch_name"
    log_info "路径: $workspace_path"
    
    # 检查工作空间是否已存在
    if [[ -d "$workspace_path" ]]; then
        log_warning "工作空间已存在: $workspace_path"
        read -p "是否覆盖现有工作空间? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "操作取消"
            exit 0
        fi
        
        # 清理现有工作空间
        cleanup_agent_workspace "$agent" "$task"
    fi
    
    # 确保在正确的基础分支上
    git checkout "$DEVELOP_BRANCH"
    git pull origin "$DEVELOP_BRANCH" 2>/dev/null || log_warning "无法从远程更新开发分支"
    
    # 创建功能分支
    if check_branch_exists "$branch_name"; then
        log_warning "分支 $branch_name 已存在，将使用现有分支"
    else
        git checkout -b "$branch_name" "$DEVELOP_BRANCH"
        log_success "创建分支: $branch_name"
    fi
    
    # 创建worktree
    mkdir -p "$workspace_path"
    git worktree add "$workspace_path" "$branch_name"
    
    # 创建Agent特定的配置文件
    create_agent_config "$agent" "$task" "$workspace_path"
    
    # 设置Git配置
    (
        cd "$workspace_path"
        git config user.name "${AGENTS[$agent]}"
        git config user.email "$agent@ai-development.local"
    )
    
    log_success "工作空间创建完成: $workspace_path"
    log_info "切换到工作空间: cd $workspace_path"
}

# 创建Agent特定配置
create_agent_config() {
    local agent=$1
    local task=$2
    local workspace_path=$3
    
    local config_file="$workspace_path/.agent-config"
    
    cat > "$config_file" << EOF
# Agent工作空间配置
AGENT_TYPE=$agent
AGENT_NAME=${AGENTS[$agent]}
TASK_NAME=$task
WORKSPACE_PATH=$workspace_path
BRANCH_NAME=feature/${agent}/${task}
CREATED_DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Agent特定设置
EOF
    
    case $agent in
        "frontend")
            cat >> "$config_file" << EOF
# 前端开发环境
NODE_ENV=development
VITE_DEV_SERVER_PORT=3000
STORYBOOK_PORT=6006
EOF
            ;;
        "backend")
            cat >> "$config_file" << EOF
# 后端开发环境
ENV=development
DEBUG=true
DB_HOST=localhost
API_PORT=8000
EOF
            ;;
        "devops")
            cat >> "$config_file" << EOF
# DevOps环境
ENVIRONMENT=development
DOCKER_COMPOSE_FILE=docker-compose.dev.yml
KUBE_NAMESPACE=dev
EOF
            ;;
        "qa")
            cat >> "$config_file" << EOF
# QA测试环境
TEST_ENV=staging
BROWSER=chromium
PARALLEL_TESTS=4
COVERAGE_THRESHOLD=80
EOF
            ;;
    esac
}

# 列出所有Agent工作空间
list_workspaces() {
    log_info "当前Agent工作空间列表:"
    echo
    
    # 显示Git worktree列表
    git worktree list | grep -E "(workspace|feature)" || log_info "没有找到Agent工作空间"
    echo
    
    # 显示详细信息
    if [[ -d "$WORKSPACE_ROOT" ]]; then
        for agent in "${!AGENTS[@]}"; do
            agent_dir="$WORKSPACE_ROOT/$agent"
            if [[ -d "$agent_dir" ]]; then
                local task_count=$(find "$agent_dir" -maxdepth 1 -type d | wc -l)
                ((task_count--)) # 减去agent目录本身
                
                if [[ $task_count -gt 0 ]]; then
                    printf "${BLUE}%-12s${NC} %s (%d个任务)\n" "${AGENTS[$agent]}" "$agent" "$task_count"
                    
                    # 列出任务
                    for task_dir in "$agent_dir"/*; do
                        if [[ -d "$task_dir" ]]; then
                            local task_name=$(basename "$task_dir")
                            local branch_name="feature/${agent}/${task_name}"
                            local status="unknown"
                            
                            if git show-ref --verify --quiet refs/heads/$branch_name; then
                                if [[ -f "$task_dir/.git" ]]; then
                                    status="${GREEN}active${NC}"
                                else
                                    status="${YELLOW}detached${NC}"
                                fi
                            else
                                status="${RED}missing${NC}"
                            fi
                            
                            printf "  ├─ %-20s %s\n" "$task_name" "$status"
                        fi
                    done
                fi
            fi
        done
    fi
}

# 同步Agent工作空间
sync_workspace() {
    local agent=$1
    
    if [[ -z "$agent" ]]; then
        log_error "请指定Agent类型"
        exit 1
    fi
    
    if [[ ! ${AGENTS[$agent]+_} ]]; then
        log_error "未知的Agent类型: $agent"
        exit 1
    fi
    
    log_info "同步 ${AGENTS[$agent]} 工作空间..."
    
    local agent_dir="$WORKSPACE_ROOT/$agent"
    if [[ ! -d "$agent_dir" ]]; then
        log_error "Agent工作空间不存在: $agent_dir"
        exit 1
    fi
    
    # 同步所有任务工作空间
    for task_dir in "$agent_dir"/*; do
        if [[ -d "$task_dir" && -f "$task_dir/.git" ]]; then
            local task_name=$(basename "$task_dir")
            log_info "同步任务: $task_name"
            
            (
                cd "$task_dir"
                
                # 拉取最新的develop分支更改
                git fetch origin
                
                # 检查是否有冲突
                if git merge-base --is-ancestor origin/develop HEAD; then
                    log_info "  当前分支已包含最新的develop分支更改"
                else
                    log_info "  合并develop分支的最新更改..."
                    if git merge origin/develop --no-edit; then
                        log_success "  合并成功"
                    else
                        log_warning "  合并冲突，需要手动解决"
                        echo "  位置: $task_dir"
                    fi
                fi
            )
        fi
    done
    
    log_success "${AGENTS[$agent]} 工作空间同步完成"
}

# 合并Agent工作空间到目标分支
merge_workspace() {
    local agent=$1
    local target_branch=${2:-$DEVELOP_BRANCH}
    
    if [[ -z "$agent" ]]; then
        log_error "请指定Agent类型"
        exit 1
    fi
    
    if [[ ! ${AGENTS[$agent]+_} ]]; then
        log_error "未知的Agent类型: $agent"
        exit 1
    fi
    
    log_info "合并 ${AGENTS[$agent]} 工作空间到 $target_branch 分支..."
    
    local agent_dir="$WORKSPACE_ROOT/$agent"
    if [[ ! -d "$agent_dir" ]]; then
        log_error "Agent工作空间不存在: $agent_dir"
        exit 1
    fi
    
    # 切换到目标分支
    git checkout "$target_branch"
    git pull origin "$target_branch" 2>/dev/null || log_warning "无法从远程更新目标分支"
    
    # 合并所有已完成的任务分支
    for task_dir in "$agent_dir"/*; do
        if [[ -d "$task_dir" && -f "$task_dir/.git" ]]; then
            local task_name=$(basename "$task_dir")
            local branch_name="feature/${agent}/${task_name}"
            
            log_info "检查任务分支: $branch_name"
            
            # 检查分支是否可以合并
            (
                cd "$task_dir"
                
                # 检查工作目录是否干净
                if [[ -n $(git status --porcelain) ]]; then
                    log_warning "  任务 $task_name 有未提交的更改，跳过合并"
                    return
                fi
                
                # 推送分支到远程
                git push origin "$branch_name" 2>/dev/null || log_warning "  无法推送分支到远程"
            )
            
            # 执行合并
            if git merge "$branch_name" --no-edit; then
                log_success "  任务 $task_name 合并成功"
                
                # 询问是否删除已合并的分支
                read -p "  是否删除已合并的分支 $branch_name? (y/N): " -n 1 -r
                echo
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    git branch -d "$branch_name"
                    git push origin --delete "$branch_name" 2>/dev/null || log_warning "无法删除远程分支"
                    log_info "  分支 $branch_name 已删除"
                fi
            else
                log_error "  任务 $task_name 合并失败，可能存在冲突"
            fi
        fi
    done
    
    log_success "${AGENTS[$agent]} 工作空间合并完成"
}

# 清理Agent工作空间
cleanup_workspace() {
    local agent=$1
    local task=$2
    
    if [[ -z "$agent" ]]; then
        log_error "请指定Agent类型"
        exit 1
    fi
    
    if [[ ! ${AGENTS[$agent]+_} ]]; then
        log_error "未知的Agent类型: $agent"
        exit 1
    fi
    
    local agent_dir="$WORKSPACE_ROOT/$agent"
    
    if [[ -n "$task" ]]; then
        # 清理特定任务
        cleanup_agent_workspace "$agent" "$task"
    else
        # 清理整个Agent工作空间
        log_warning "这将清理 ${AGENTS[$agent]} 的所有工作空间"
        read -p "确认继续? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "操作取消"
            exit 0
        fi
        
        if [[ -d "$agent_dir" ]]; then
            for task_dir in "$agent_dir"/*; do
                if [[ -d "$task_dir" ]]; then
                    local task_name=$(basename "$task_dir")
                    cleanup_agent_workspace "$agent" "$task_name"
                fi
            done
        fi
    fi
}

# 清理具体的Agent任务工作空间
cleanup_agent_workspace() {
    local agent=$1
    local task=$2
    local workspace_path="$WORKSPACE_ROOT/$agent/$task"
    local branch_name="feature/${agent}/${task}"
    
    log_info "清理任务工作空间: $task"
    
    if [[ -d "$workspace_path" ]]; then
        # 移除worktree
        if git worktree list | grep -q "$workspace_path"; then
            git worktree remove "$workspace_path" --force
            log_info "  移除worktree: $workspace_path"
        fi
        
        # 删除目录
        rm -rf "$workspace_path"
        log_info "  删除目录: $workspace_path"
    fi
    
    # 询问是否删除分支
    if check_branch_exists "$branch_name"; then
        read -p "  是否删除分支 $branch_name? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            git branch -D "$branch_name"
            git push origin --delete "$branch_name" 2>/dev/null || log_warning "无法删除远程分支"
            log_info "  分支 $branch_name 已删除"
        fi
    fi
    
    log_success "任务工作空间清理完成: $task"
}

# 显示所有Agent工作状态
show_status() {
    log_info "多Agent并行开发状态概览"
    echo
    
    # Git仓库状态
    echo "📁 Git仓库状态:"
    git status --porcelain | head -10
    if [[ $(git status --porcelain | wc -l) -gt 10 ]]; then
        echo "   ... 还有 $(($(git status --porcelain | wc -l) - 10)) 个文件"
    fi
    echo
    
    # 分支信息
    echo "🌿 分支信息:"
    echo "   当前分支: $(git branch --show-current)"
    echo "   主分支: $MAIN_BRANCH"
    echo "   开发分支: $DEVELOP_BRANCH"
    echo
    
    # Agent工作空间状态
    echo "👥 Agent工作空间状态:"
    for agent in "${!AGENTS[@]}"; do
        local agent_dir="$WORKSPACE_ROOT/$agent"
        local active_tasks=0
        local total_tasks=0
        
        if [[ -d "$agent_dir" ]]; then
            for task_dir in "$agent_dir"/*; do
                if [[ -d "$task_dir" ]]; then
                    ((total_tasks++))
                    if [[ -f "$task_dir/.git" ]]; then
                        ((active_tasks++))
                    fi
                fi
            done
        fi
        
        local status_color="${GREEN}"
        if [[ $active_tasks -eq 0 ]]; then
            status_color="${YELLOW}"
        fi
        
        printf "   ${status_color}%-15s${NC} %d/%d 活跃任务\n" "${AGENTS[$agent]}" "$active_tasks" "$total_tasks"
    done
    echo
    
    # Worktree列表
    echo "🔧 活跃Worktree:"
    git worktree list | grep workspace || echo "   无活跃的Agent工作空间"
}

# 切换到Agent工作空间
switch_workspace() {
    local agent=$1
    
    if [[ -z "$agent" ]]; then
        log_error "请指定Agent类型"
        exit 1
    fi
    
    if [[ ! ${AGENTS[$agent]+_} ]]; then
        log_error "未知的Agent类型: $agent"
        exit 1
    fi
    
    local agent_dir="$WORKSPACE_ROOT/$agent"
    
    if [[ ! -d "$agent_dir" ]]; then
        log_error "Agent工作空间不存在: $agent_dir"
        exit 1
    fi
    
    # 列出可用任务
    echo "可用的 ${AGENTS[$agent]} 任务工作空间:"
    local tasks=()
    local i=1
    
    for task_dir in "$agent_dir"/*; do
        if [[ -d "$task_dir" && -f "$task_dir/.git" ]]; then
            local task_name=$(basename "$task_dir")
            tasks+=("$task_name")
            echo "  $i) $task_name"
            ((i++))
        fi
    done
    
    if [[ ${#tasks[@]} -eq 0 ]]; then
        log_warning "没有可用的任务工作空间"
        exit 0
    fi
    
    # 选择任务
    read -p "选择任务编号 (1-${#tasks[@]}): " -r
    if [[ $REPLY =~ ^[0-9]+$ ]] && [[ $REPLY -ge 1 ]] && [[ $REPLY -le ${#tasks[@]} ]]; then
        local selected_task="${tasks[$((REPLY-1))]}"
        local workspace_path="$agent_dir/$selected_task"
        
        log_success "切换到工作空间: $workspace_path"
        echo "执行命令: cd $workspace_path"
        
        # 创建一个临时脚本来切换目录
        echo "cd $workspace_path" > /tmp/switch_workspace.sh
        echo "请运行: source /tmp/switch_workspace.sh"
    else
        log_error "无效的选择"
        exit 1
    fi
}

# 主函数
main() {
    case "${1:-}" in
        "init")
            init_workspace
            ;;
        "create-workspace")
            create_agent_workspace "$2" "$3"
            ;;
        "list-workspaces"|"list")
            list_workspaces
            ;;
        "sync-workspace"|"sync")
            sync_workspace "$2"
            ;;
        "merge-workspace"|"merge")
            merge_workspace "$2" "$3"
            ;;
        "cleanup-workspace"|"cleanup")
            cleanup_workspace "$2" "$3"
            ;;
        "status")
            show_status
            ;;
        "switch-workspace"|"switch")
            switch_workspace "$2"
            ;;
        "help"|"-h"|"--help"|"")
            show_help
            ;;
        *)
            log_error "未知命令: $1"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"