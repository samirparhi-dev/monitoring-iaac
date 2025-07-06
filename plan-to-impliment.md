# Repo to impliment Observability as Iaac:
OpenTofu is a fully Terraform-compatible open-source alternative that uses the same HashiCorp Configuration Language (HCL) and syntax. So you can directly use your Terraform code with OpenTofu , with minimal or no changes.

### This will implement stack :

- Fluent Bit (DaemonSet)
- Loki (simple mode)
- Prometheus
- Thanos Sidecar
- Grafana
- Namespaces for logging & monitoring

### File Structure:
observability/
├── main.tf
├── variables.tf
├── outputs.tf
└── helm-values/
    ├── loki-values.yaml
    ├── prometheus-values.yaml
    ├── thanos-values.yaml
    └── grafana-values.yaml


### Process to Run locally :
- clone the repo
- run `cd monitoring-iaac`
- Manipulate helm values
- run `tofu` script
#### Run In Sequence below terraform command
```
tofu init
tofu apply
echo "Access Grafana at: $(tofu output grafana_url)"
```

Login with:

```
Username: admin
Password: secure-password (change it in values.yaml)
```

#### Main Consideration
- Configure to stream data properly to Our infra from Cloud and local
- All PVC and Infra should be higly available
- Helm Chart to be added and manipulated properly for individual tools
- Terraform backend Should be propely configured to reuse infra structure state.

### Next Steps
Add OpenSearch for full-text search
Use MinIO or S3-compatible storage for Loki + Thanos
Add alerting rules in Prometheus and Loki
Add Kubernetes dashboards to Grafana
Add Vector or Promtail if needed