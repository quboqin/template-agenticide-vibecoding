# Claude Code 定制化研发流程配置

基于Spec-Driven和Test-Driven开发的全流程AI辅助研发系统。

## 📋 研发流程定义

### Phase 1: 需求分析与规划 (Requirements & Planning)
- **目标**: 明确产品需求，制定开发计划
- **输出**: PRD文档、技术规格说明、任务分解
- **负责角色**: PM Agent, Business Analyst Agent
- **验收标准**: 需求清单完整，优先级明确，可测试性充分

### Phase 2: 架构设计 (Architecture Design)  
- **目标**: 系统架构设计，技术选型
- **输出**: 架构图、API设计文档、数据库设计
- **负责角色**: Architect Agent, Senior Engineer Agent
- **验收标准**: 架构可扩展，技术栈合理，性能预期达标

### Phase 3: 代码实现 (Implementation)
- **目标**: 功能模块开发，接口实现
- **输出**: 可运行代码、单元测试、代码文档
- **负责角色**: Frontend Agent, Backend Agent, DevOps Agent
- **验收标准**: 代码质量良好，测试覆盖率≥80%，符合规范

### Phase 4: 测试验证 (Testing & Validation)
- **目标**: 功能测试，性能测试，安全测试
- **输出**: 测试报告、缺陷清单、修复方案
- **负责角色**: QA Agent, Security Agent, Performance Agent
- **验收标准**: 功能正确性，性能满足要求，安全漏洞为0

### Phase 5: 部署上线 (Deployment)
- **目标**: 生产环境部署，监控配置
- **输出**: 部署文档、监控配置、运维手册
- **负责角色**: DevOps Agent, SRE Agent
- **验收标准**: 部署成功，监控正常，回滚机制可用

### Phase 6: 监控运维 (Monitoring & Operations)
- **目标**: 系统监控，问题排查，持续优化
- **输出**: 监控报告、性能分析、优化建议
- **负责角色**: SRE Agent, Performance Agent
- **验收标准**: 系统稳定，性能符合SLA，问题快速定位

## 🤖 Sub-Agents 角色定义

### PM Agent (项目管理)
```yaml
role: "PM Agent"
responsibilities:
  - 项目任务分解与跟踪
  - 进度管理与风险控制
  - 跨团队协调沟通
  - 质量把关与验收
tools: ["TodoWrite", "Task", "Sequential", "Grep"]
commands: ["/plan", "/track", "/review", "/estimate"]
hooks: ["on_task_create", "on_milestone_check", "on_deadline_approach"]
```

### Architect Agent (架构师)
```yaml
role: "Architect Agent"  
responsibilities:
  - 系统架构设计
  - 技术选型决策
  - 代码质量把关
  - 技术债务管理
tools: ["Context7", "Sequential", "Read", "Write"]
commands: ["/design", "/analyze", "/review-arch", "/refactor"]
hooks: ["on_design_phase", "on_code_review", "on_tech_debt_alert"]
```

### Frontend Agent (前端开发)
```yaml
role: "Frontend Agent"
responsibilities:
  - UI/UX组件开发
  - 前端性能优化
  - 用户体验设计
  - 响应式布局实现
tools: ["Magic", "Context7", "Playwright", "Edit"]
commands: ["/ui-create", "/component-gen", "/optimize-fe", "/test-ui"]
hooks: ["on_ui_task", "on_component_request", "on_performance_check"]
```

### Backend Agent (后端开发)
```yaml
role: "Backend Agent"
responsibilities:
  - API接口开发
  - 数据库设计
  - 业务逻辑实现
  - 性能优化
tools: ["Context7", "Sequential", "Bash", "Edit"]
commands: ["/api-create", "/db-design", "/optimize-be", "/test-api"]
hooks: ["on_api_task", "on_db_change", "on_performance_issue"]
```

### DevOps Agent (运维开发)
```yaml
role: "DevOps Agent"
responsibilities:
  - CI/CD流水线构建
  - 容器化部署
  - 监控系统搭建
  - 自动化运维
tools: ["Bash", "Context7", "Sequential", "Write"]
commands: ["/deploy", "/monitor", "/pipeline", "/infra"]
hooks: ["on_deploy_request", "on_monitoring_alert", "on_pipeline_fail"]
```

### QA Agent (质量保证)
```yaml
role: "QA Agent"
responsibilities:
  - 测试用例设计
  - 自动化测试执行
  - 缺陷跟踪管理
  - 质量报告生成
tools: ["Playwright", "Sequential", "Bash", "TodoWrite"]
commands: ["/test-create", "/test-run", "/bug-track", "/quality-report"]
hooks: ["on_test_phase", "on_bug_found", "on_quality_gate"]
```

### Security Agent (安全专家)
```yaml
role: "Security Agent"
responsibilities:
  - 安全漏洞扫描
  - 代码安全审计
  - 权限控制设计
  - 安全最佳实践
tools: ["Grep", "Sequential", "Context7", "Bash"]
commands: ["/security-scan", "/audit", "/permission-design", "/security-check"]
hooks: ["on_security_review", "on_vulnerability_found", "on_permission_change"]
```

## 🛠️ 定制化 Commands

### /spec-create [domain] [type]
创建技术规格文档
- **用法**: `/spec-create frontend component-library`
- **输出**: 详细的技术规格文档
- **Agent**: Architect Agent + Domain Expert

### /prd-gen [feature] [priority]
生成产品需求文档
- **用法**: `/prd-gen user-auth high`
- **输出**: 完整的PRD文档
- **Agent**: PM Agent + Business Analyst

### /task-break [feature] [granularity]
任务分解与估算
- **用法**: `/task-break payment-system detailed`
- **输出**: 任务列表、时间估算、依赖关系
- **Agent**: PM Agent + Architect Agent

### /code-review [scope] [focus]
代码审查与质量检查
- **用法**: `/code-review src/auth security`
- **输出**: 代码审查报告、改进建议
- **Agent**: Architect Agent + Security Agent

### /test-gen [type] [coverage]
测试用例生成
- **用法**: `/test-gen e2e 90%`
- **输出**: 测试用例、测试脚本
- **Agent**: QA Agent + Developer Agents

### /deploy-prep [env] [strategy]
部署准备与配置
- **用法**: `/deploy-prep production blue-green`
- **输出**: 部署配置、检查清单
- **Agent**: DevOps Agent + SRE Agent

### /monitor-setup [service] [metrics]
监控系统配置
- **用法**: `/monitor-setup payment-api performance`
- **输出**: 监控配置、告警规则
- **Agent**: DevOps Agent + SRE Agent

### /progress-sync
项目进度同步
- **用法**: `/progress-sync`
- **输出**: 进度报告、风险提醒
- **Agent**: PM Agent

## 🔗 Hooks 配置

### Git Hooks
```yaml
pre-commit:
  - trigger: "代码提交前"
  - actions: ["code-review", "test-run", "security-scan"]
  - agents: ["QA Agent", "Security Agent"]

pre-push:
  - trigger: "代码推送前"  
  - actions: ["integration-test", "build-check"]
  - agents: ["DevOps Agent", "QA Agent"]

post-merge:
  - trigger: "代码合并后"
  - actions: ["deploy-dev", "notify-team"]
  - agents: ["DevOps Agent", "PM Agent"]
```

### Project Hooks
```yaml
on_milestone_reach:
  - trigger: "里程碑达成"
  - actions: ["quality-gate-check", "progress-report"]
  - agents: ["PM Agent", "QA Agent"]

on_deadline_approach:
  - trigger: "截止日期临近"
  - actions: ["risk-assessment", "resource-rebalance"]
  - agents: ["PM Agent", "Architect Agent"]

on_bug_critical:
  - trigger: "严重缺陷发现"
  - actions: ["emergency-response", "hotfix-plan"]
  - agents: ["PM Agent", "Senior Engineer Agent"]
```

## 📊 MCP 服务器集成

### Context7 (文档与最佳实践)
- **用途**: 技术文档查询、最佳实践参考
- **支持Agents**: All Agents
- **主要场景**: 技术选型、框架使用、问题解决

### Sequential (复杂分析与推理)
- **用途**: 多步骤分析、逻辑推理、问题诊断
- **支持Agents**: PM Agent, Architect Agent, QA Agent
- **主要场景**: 架构设计、问题分析、决策支持

### Magic (UI组件生成)
- **用途**: 前端组件生成、设计系统构建
- **支持Agents**: Frontend Agent, Designer Agent
- **主要场景**: UI开发、组件库建设、原型制作

### Playwright (测试自动化)
- **用途**: E2E测试、性能测试、UI测试
- **支持Agents**: QA Agent, Frontend Agent
- **主要场景**: 自动化测试、性能监控、UI验证

## 📋 项目任务管理

### 任务状态定义
- **backlog**: 待规划任务
- **planned**: 已规划任务
- **in-progress**: 进行中任务
- **review**: 审查中任务
- **testing**: 测试中任务
- **done**: 已完成任务
- **blocked**: 阻塞任务

### 任务优先级
- **P0**: 紧急关键 (24小时内)
- **P1**: 高优先级 (3天内)
- **P2**: 中等优先级 (1周内)
- **P3**: 低优先级 (2周内)

### 进度文件格式
项目进度保存在 `PROJECT_PROGRESS.md` 文件中，支持跨会话状态管理。

## 🌿 Git Worktree 多Agent并行开发

### Worktree 策略
```yaml
主分支: main
功能分支: feature/[agent-name]/[feature-name]
集成分支: integration/[sprint-name]
发布分支: release/[version]
```

### Agent 工作空间分配
```yaml
pm-workspace: ./workspace/pm/
arch-workspace: ./workspace/architect/
fe-workspace: ./workspace/frontend/
be-workspace: ./workspace/backend/
devops-workspace: ./workspace/devops/
qa-workspace: ./workspace/qa/
```

### 并行开发工作流
1. PM Agent 创建任务分支
2. 各Agent在独立worktree中开发
3. 定期集成到integration分支
4. QA Agent在integration分支测试
5. 测试通过后合并到main分支

## ⚙️ 质量控制

### Code Review 检查点
- 代码规范性检查
- 安全漏洞扫描
- 性能影响评估
- 测试覆盖率验证

### 自动化检查
- 静态代码分析
- 依赖漏洞扫描  
- 单元测试执行
- 集成测试验证

### 质量门禁
- 测试覆盖率 ≥ 80%
- 代码复杂度 ≤ 10
- 安全漏洞 = 0
- 性能回归 = 0

## 📞 通知与协作

### 通知触发条件
- 任务状态变更
- 质量门禁失败
- 部署状态更新
- 紧急问题发生

### 协作机制
- 每日站会自动生成
- 周报进度汇总
- 里程碑达成通知
- 风险预警提醒

---

*此配置文件支持持续迭代优化，可根据团队实际情况调整流程和规则。*