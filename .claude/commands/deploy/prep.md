---
allowed-tools: ["Read", "Write", "Bash(docker:*)", "Bash(kubectl:*)", "Bash(terraform:*)", "Bash(git:*)", "TodoWrite"]
description: "Prepare and validate deployment with comprehensive checks"
usage: "/deploy:prep [environment] [strategy] [--validate] [--rollback] [--monitor]"
---

# Deployment Preparation Engine

Prepare deployment for $ARGUMENTS with comprehensive validation, rollback planning, and monitoring setup.

## Deployment Preparation Process:

1. **Pre-deployment Validation**
   - Validate build artifacts and dependencies
   - Run comprehensive test suites
   - Check environment configuration
   - Verify security compliance

2. **Infrastructure Preparation**
   - Provision required infrastructure
   - Configure load balancers and networking
   - Setup monitoring and logging
   - Prepare database migrations

3. **Rollback Planning**
   - Create rollback procedures
   - Backup current deployment state
   - Test rollback mechanisms
   - Document emergency procedures

4. **Deployment Orchestration**
   - Configure deployment pipeline
   - Setup health checks and monitoring
   - Plan deployment schedule
   - Coordinate team notifications

## Target Environments:

- `development`: Development environment for feature testing
- `staging`: Staging environment for integration testing
- `production`: Production environment for live deployment
- `canary`: Canary deployment for gradual rollout
- `blue-green`: Blue-green deployment for zero-downtime

## Deployment Strategies:

- `rolling`: Rolling deployment with gradual instance replacement
- `blue-green`: Blue-green deployment for instant switching
- `canary`: Canary deployment for gradual traffic shifting
- `recreation`: Recreate deployment with downtime
- `a-b-testing`: A/B testing deployment for feature validation

## Options:

- `--validate`: Run comprehensive pre-deployment validation
- `--rollback`: Prepare rollback procedures and mechanisms
- `--monitor`: Setup deployment monitoring and alerting
- `--dry-run`: Simulate deployment without actual execution
- `--schedule [time]`: Schedule deployment for specific time

## Pre-deployment Checklist:

### Code Quality Validation
- [ ] All tests pass (unit, integration, e2e)
- [ ] Code coverage meets requirements
- [ ] Security scans pass
- [ ] Performance benchmarks met
- [ ] Code review approved

### Infrastructure Readiness
- [ ] Target environment is healthy
- [ ] Required resources are available
- [ ] Network connectivity verified
- [ ] Database migrations tested
- [ ] Configuration files validated

### Security Compliance
- [ ] Security policies enforced
- [ ] Secrets and credentials secured
- [ ] SSL/TLS certificates valid
- [ ] Access controls configured
- [ ] Audit logging enabled

### Monitoring Setup
- [ ] Health checks configured
- [ ] Performance monitoring enabled
- [ ] Error tracking setup
- [ ] Log aggregation configured
- [ ] Alert rules defined

## Infrastructure as Code:

### Terraform Configuration
```hcl
# Infrastructure provisioning
resource "aws_instance" "app_server" {
  ami           = var.app_ami
  instance_type = var.instance_type
  key_name      = var.key_pair
  
  tags = {
    Name        = "${var.app_name}-${var.environment}"
    Environment = var.environment
  }
}
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        ports:
        - containerPort: 8080
```

### Docker Configuration
```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## Deployment Validation:

### Health Checks
- Application startup validation
- Database connectivity checks
- External service integration tests
- Load balancer health probes

### Performance Validation
- Response time benchmarks
- Throughput testing
- Resource utilization checks
- Scalability validation

### Security Validation
- SSL/TLS certificate validation
- Authentication and authorization tests
- Input validation and sanitization
- Security header configuration

## Rollback Procedures:

### Automated Rollback Triggers
- Health check failures
- Error rate exceeding thresholds
- Performance degradation
- Security incidents

### Rollback Steps
1. Stop traffic to new deployment
2. Route traffic to previous version
3. Scale down new deployment
4. Validate rollback success
5. Clean up failed deployment

## Output:

The command will create:
- `deployments/[environment]-deployment-plan.md`: Deployment plan
- `deployments/[environment]-rollback-plan.md`: Rollback procedures
- `deployments/validation-results.json`: Validation results
- `deployments/infrastructure/`: Infrastructure as code files

## Example Usage:

```bash
# Prepare production deployment with full validation
/deploy:prep production blue-green --validate --rollback --monitor

# Prepare staging deployment with dry run
/deploy:prep staging rolling --dry-run

# Schedule production deployment
/deploy:prep production canary --schedule "2024-01-15 02:00 UTC"
```

!echo "Preparing deployment for: $ARGUMENTS"
!mkdir -p deployments/{scripts,configs,infrastructure}