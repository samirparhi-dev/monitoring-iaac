provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Namespace for Logging
resource "kubernetes_namespace" "logging" {
  metadata {
    name = "logging"
  }
}

# Namespace for Monitoring
resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# Fluent Bit (DaemonSet for log collection)
resource "helm_release" "fluent-bit" {
  name       = "fluent-bit"
  namespace  = "logging"
  repository = "https://fluent.github.io/helm-charts "
  chart      = "fluent-bit"
  version    = "0.42.0"
}

# Loki (Simple Mode)
resource "helm_release" "loki" {
  name       = "loki"
  namespace  = "logging"
  repository = "https://grafana.github.io/helm-charts "
  chart      = "loki"
  version    = "6.7.4"
  values     = [file("${path.module}/helm-values/loki-values.yaml")]
}

# Prometheus
resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts "
  chart      = "prometheus"
  version    = "19.3.0"
  values     = [file("${path.module}/helm-values/prometheus-values.yaml")]
}

# Thanos Sidecar (Optional - attach to Prometheus)
resource "helm_release" "thanos-sidecar" {
  name       = "thanos-sidecar"
  namespace  = "monitoring"
  repository = "https://thanos.io "
  chart      = "thanos"
  version    = "0.32.0"
  values     = [file("${path.module}/helm-values/thanos-values.yaml")]
}

# Grafana
resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "monitoring"
  repository = "https://grafana.github.io/helm-charts "
  chart      = "grafana"
  version    = "6.53.1"
  values     = [file("${path.module}/helm-values/grafana-values.yaml")]
}