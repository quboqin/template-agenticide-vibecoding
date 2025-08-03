---
allowed-tools: ["Read", "Write", "Bash(kubectl:*)", "Bash(docker:*)", "Grep", "TodoWrite"]
description: "Setup comprehensive monitoring, alerting, and observability"
usage: "/deploy:monitor [service] [metrics] [--alerts] [--dashboard] [--sla]"
---

# Deployment Monitoring Setup

Setup comprehensive monitoring and observability for $ARGUMENTS with metrics collection, alerting, and dashboard creation.

## Monitoring Setup Process:

1. **Metrics Collection**
   - Configure application metrics
   - Setup infrastructure monitoring
   - Enable business metrics tracking
   - Implement custom metrics collection

2. **Alerting Configuration**
   - Define alert rules and thresholds
   - Configure notification channels
   - Setup escalation procedures
   - Test alert mechanisms

3. **Dashboard Creation**
   - Create operational dashboards
   - Setup business intelligence views
   - Implement real-time monitoring
   - Configure automated reporting

4. **SLA Monitoring**
   - Define service level objectives
   - Setup SLA tracking and reporting
   - Configure SLA breach alerting
   - Implement SLA dashboard

## Monitoring Categories:

### Application Monitoring
- `performance`: Response time, throughput, error rates
- `availability`: Uptime, health checks, service status
- `user-experience`: User journey tracking, conversion rates
- `business`: Revenue, transactions, user engagement

### Infrastructure Monitoring
- `system`: CPU, memory, disk, network utilization
- `containers`: Docker/Kubernetes metrics
- `databases`: Query performance, connection pools
- `network`: Latency, packet loss, bandwidth

### Security Monitoring
- `access`: Authentication attempts, authorization failures
- `threats`: Intrusion detection, vulnerability scans
- `compliance`: Audit logs, policy violations
- `incidents`: Security incident tracking

## Metrics Types:

- `counters`: Event counts (requests, errors, transactions)
- `gauges`: Current values (memory usage, active users)
- `histograms`: Value distributions (response times)
- `summaries`: Statistical summaries (percentiles)

## Options:

- `--alerts`: Configure alerting rules and notifications
- `--dashboard`: Create monitoring dashboards
- `--sla`: Setup SLA monitoring and reporting
- `--real-time`: Enable real-time monitoring
- `--retention [period]`: Set data retention period

## Monitoring Stack:

### Metrics Collection
- **Prometheus**: Time-series metrics collection
- **Grafana**: Visualization and dashboards
- **AlertManager**: Alert routing and notification
- **Jaeger**: Distributed tracing

### Log Management
- **ELK Stack**: Elasticsearch, Logstash, Kibana
- **Fluentd**: Log collection and forwarding
- **Loki**: Log aggregation system

### APM Tools
- **New Relic**: Application performance monitoring
- **DataDog**: Infrastructure and application monitoring
- **Dynatrace**: Full-stack monitoring

## Alert Configuration:

### Alert Rules
```yaml
groups:
  - name: application.rules
    rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value }} for {{ $labels.instance }}"
```

### Notification Channels
- Slack/Teams integration
- Email notifications
- PagerDuty escalation
- SMS alerts for critical issues
- Webhook integrations

## Dashboard Configuration:

### Operational Dashboard
- System health overview
- Performance metrics summary
- Error rate and availability
- Resource utilization trends

### Business Dashboard
- Key business metrics
- User engagement analytics
- Revenue and conversion tracking
- Customer satisfaction scores

### Infrastructure Dashboard
- Server and container metrics
- Database performance
- Network and storage utilization
- Capacity planning insights

## SLA Configuration:

### Service Level Objectives (SLOs)
- Availability: 99.9% uptime
- Performance: 95% of requests < 200ms
- Throughput: Handle 1000 RPS
- Error Rate: < 0.1% error rate

### SLA Monitoring
```yaml
slo_config:
  - name: api_availability
    objective: 99.9
    window: 30d
    query: 'sum(rate(http_requests_total[5m])) - sum(rate(http_requests_total{status=~"5.."}[5m]))'
    
  - name: response_time
    objective: 95
    window: 30d
    query: 'histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) < 0.2'
```

## Health Checks:

### Application Health
- Service startup validation
- Database connectivity
- External service dependencies
- Business logic validation

### Infrastructure Health
- Container/pod health status
- Load balancer health
- Network connectivity
- Resource availability

## Log Management:

### Log Levels
- ERROR: Application errors and exceptions
- WARN: Warning conditions
- INFO: General information messages
- DEBUG: Detailed debugging information

### Log Structure
```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "ERROR",
  "service": "user-service",
  "trace_id": "abc123",
  "message": "Database connection failed",
  "context": {
    "user_id": "12345",
    "request_id": "req-789"
  }
}
```

## Output:

The command will create:
- `monitoring/prometheus-config.yml`: Prometheus configuration
- `monitoring/grafana-dashboards/`: Dashboard definitions
- `monitoring/alert-rules.yml`: Alert rule definitions
- `monitoring/sla-config.yml`: SLA monitoring configuration
- `monitoring/health-checks.sh`: Health check scripts

## Example Usage:

```bash
# Setup comprehensive monitoring with alerts
/deploy:monitor user-service performance --alerts --dashboard

# Setup SLA monitoring
/deploy:monitor payment-api availability --sla --alerts

# Setup business metrics monitoring
/deploy:monitor e-commerce-platform business --dashboard --real-time
```

!echo "Setting up monitoring for: $ARGUMENTS"
!mkdir -p monitoring/{dashboards,alerts,health-checks}