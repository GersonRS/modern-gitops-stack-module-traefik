locals {
  azure_dns_label_name = format("%s-%s", var.cluster_name, replace(var.base_domain, ".", "-"))

  helm_values = [{
    traefik = {
      service = {
        annotations = {
          "service.beta.kubernetes.io/azure-dns-label-name" = local.azure_dns_label_name
        }
      }
    }
  }]
}
