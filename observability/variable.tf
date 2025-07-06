variable "cluster_name" {
  description = "Name of your Kubernetes cluster"
  type        = string
  default     = "onprem-cluster"
}

variable "storage_class" {
  description = "Storage class for PVCs"
  type        = string
  default     = "local-path"
}