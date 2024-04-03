locals {
  helm_values = [{
    traefik = {
      service = {
        annotations = {
          "service.beta.kubernetes.io/exoscale-loadbalancer-id"                      = var.nlb_id
          "service.beta.kubernetes.io/exoscale-loadbalancer-external"                = "true"
          "service.beta.kubernetes.io/exoscale-loadbalancer-service-instancepool-id" = var.router_instance_pool_id
        }
      }
      nodeSelector = {
        "node.exoscale.net/nodepool-id" = var.router_nodepool_id
      }
      tolerations = [{
        key      = "nodepool"
        operator = "Equal"
        value    = "router"
        effect   = "NoSchedule"
      }]
    }
  }]
}
