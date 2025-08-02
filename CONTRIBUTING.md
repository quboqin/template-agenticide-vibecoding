# 贡献指南

欢迎为Claude Code定制化研发流程系统做出贡献！我们的目标是建立一个开放、协作的AI辅助软件开发生态系统。

## 🎯 贡献方式

### 🐛 报告问题
- 使用[GitHub Issues](https://github.com/your-org/template-agenticide-vibecoding/issues)报告bug
- 提供详细的重现步骤和环境信息
- 包含相关的配置文件和错误日志

### ✨ 功能建议
- 在[GitHub Discussions](https://github.com/your-org/template-agenticide-vibecoding/discussions)中提出新功能想法
- 描述功能的使用场景和预期效果
- 参与社区讨论，完善功能设计

### 📝 文档改进
- 修复文档中的错误或不清楚的地方
- 添加更多使用示例和最佳实践
- 翻译文档到其他语言

### 🔧 代码贡献
- 修复已知的bug
- 实现新功能
- 性能优化
- 添加新的Agent角色或Commands

## 🚀 开发流程

### 环境准备
1. Fork本仓库
2. 克隆你的fork到本地
3. 安装Claude Code和必要依赖
4. 运行初始化脚本

```bash
git clone https://github.com/your-username/template-agenticide-vibecoding.git
cd template-agenticide-vibecoding
./scripts/git-worktree-manager.sh init
```

### 使用我们自己的工作流
我们使用自己创建的研发流程来管理这个项目：

1. **创建Agent工作空间**
```bash
# 根据你的贡献类型选择合适的Agent
./scripts/git-worktree-manager.sh create-workspace frontend ui-improvement
./scripts/git-worktree-manager.sh create-workspace backend api-enhancement
./scripts/git-worktree-manager.sh create-workspace qa testing-improvement
```

2. **使用定制化Commands**
```bash
# 创建功能规格
/spec-create enhancement detailed --template

# 实现功能
/implement new-feature --test-driven

# 代码审查
/code-review . --focus all --automated

# 运行测试
/test-run all local --coverage
```

### 分支策略
- `main`: 稳定的发布分支
- `develop`: 开发集成分支
- `feature/{agent}/{feature-name}`: 功能开发分支
- `hotfix/{issue-id}`: 紧急修复分支

### 代码规范
- 遵循项目现有的代码风格
- 使用有意义的提交信息
- 为新功能添加测试用例
- 更新相关文档

### 提交信息规范
使用[Conventional Commits](https://conventionalcommits.org/)格式：

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

类型：
- `feat`: 新功能
- `fix`: bug修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建工具或辅助工具更改

示例：
```
feat(agents): add Data Agent for data science workflows

- Add data-agent.md configuration
- Include data analysis commands
- Integrate with Jupyter and pandas tools
- Add data pipeline automation hooks

Closes #123
```

## 🤖 Agent角色贡献

### 现有Agent改进
为现有的7个Agent角色贡献改进：
- **PM Agent**: 项目管理工具和方法
- **Architect Agent**: 架构模式和设计原则
- **Frontend Agent**: 前端工具和框架支持
- **Backend Agent**: 后端技术和最佳实践
- **DevOps Agent**: 运维工具和自动化
- **QA Agent**: 测试策略和工具
- **Security Agent**: 安全工具和合规要求

### 新Agent角色
提议和实现新的Agent角色：
1. 在`agents/`目录创建新的Agent配置文件
2. 遵循现有Agent的文档结构
3. 定义角色职责、工具、Commands和Hooks
4. 更新CLAUDE.md中的Agent配置
5. 添加使用示例和测试用例

### Agent配置模板
```markdown
# New Agent (新角色专家)

## 🎯 角色定义
[角色描述]

## 📋 核心职责
[主要职责列表]

## 🛠️ 主要工具
[工具配置]

## 📊 定制化Commands
[Commands定义]

## 🔗 Hooks配置
[Hooks配置]

## 📈 工作流程
[工作流程图]

## 📊 关键指标
[KPI指标]
```

## 📊 质量标准

### 代码质量
- 代码覆盖率 ≥ 80%
- 没有明显的性能问题
- 遵循最佳实践和设计模式
- 包含适当的错误处理

### 文档质量
- 清晰的功能描述
- 包含使用示例
- API文档完整
- 更新日志记录

### 测试要求
- 单元测试覆盖新功能
- 集成测试验证工作流
- 手动测试验证用户体验
- 性能测试（如适用）

## 🔄 Pull Request流程

### 创建PR前检查
- [ ] 功能完整实现
- [ ] 所有测试通过
- [ ] 文档已更新
- [ ] 代码已审查
- [ ] 提交信息符合规范

### PR模板
```markdown
## 📝 更改描述
[简要描述你的更改]

## 🎯 更改类型
- [ ] Bug修复
- [ ] 新功能
- [ ] 文档更新
- [ ] 性能优化
- [ ] 代码重构

## 🧪 测试
- [ ] 单元测试
- [ ] 集成测试
- [ ] 手动测试
- [ ] 性能测试

## 📋 检查清单
- [ ] 代码符合项目规范
- [ ] 添加或更新了测试
- [ ] 更新了相关文档
- [ ] 提交信息符合规范
- [ ] 没有破坏性更改

## 📸 截图/演示
[如适用，添加截图或演示链接]

## 🔗 相关Issue
Closes #[issue number]
```

### 审查流程
1. 自动化检查（CI/CD）
2. 代码审查（至少1个维护者）
3. 功能测试验证
4. 文档审查
5. 合并到develop分支

## 🏆 贡献者认可

### 贡献者类型
- **核心维护者**: 长期活跃的核心贡献者
- **领域专家**: 特定Agent或功能领域的专家
- **社区贡献者**: 提供有价值贡献的社区成员
- **文档贡献者**: 专注于文档和教程的贡献者

### 认可方式
- 在README.md中列出贡献者
- 年度贡献者奖励
- 社区活动邀请
- 技术分享机会

## 📚 学习资源

### 必读文档
- [README.md](README.md) - 项目概述和快速开始
- [CLAUDE.md](CLAUDE.md) - 核心配置和架构
- [agents/](agents/) - Agent角色详细说明
- [config/](config/) - 系统配置文件说明

### 推荐学习
- [Claude Code官方文档](https://docs.anthropic.com/claude-code)
- [MCP协议文档](https://modelcontextprotocol.io/)
- [Git Worktree用法](https://git-scm.com/docs/git-worktree)
- [YAML配置语法](https://yaml.org/spec/)

### 实践项目
建议在小型项目中先实践使用本系统，然后再贡献改进。

## 🤝 社区行为准则

### 我们的承诺
我们致力于为每个人提供友好、安全和包容的环境，不论年龄、身体残疾、民族、性别认同、经验水平、国籍、个人形象、种族、宗教或性取向。

### 我们的标准
促进积极环境的行为包括：
- 使用欢迎和包容的语言
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

### 执行责任
项目维护者有责任澄清可接受行为标准，并在发生不可接受行为时采取适当和公平的纠正措施。

## 📞 获得帮助

### 联系方式
- **GitHub Issues**: 技术问题和bug报告
- **GitHub Discussions**: 功能讨论和使用问题
- **Email**: maintainers@your-org.com
- **Discord**: [社区Discord频道](https://discord.gg/your-channel)

### 响应时间
- Issues: 2-3个工作日
- Pull Requests: 3-5个工作日
- Discussions: 1-2个工作日
- 紧急问题: 24小时内

---

感谢您考虑为Claude Code定制化研发流程系统做出贡献！每一个贡献都让这个项目变得更好。

**一起构建AI辅助软件开发的未来！** 🚀