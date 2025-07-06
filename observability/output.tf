output "grafana_url" {
  value = "http://grafana.monitoring.svc.cluster.local"
}

output "prometheus_url" {
  value = "http://prometheus-server.monitoring.svc.cluster.local"
}

output "loki_url" {
  value = "http://loki.logging.svc.cluster.local:3100"
}