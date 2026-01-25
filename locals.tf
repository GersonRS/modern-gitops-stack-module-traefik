locals {
  helm_values = [{
    traefik = {
      ingressRoute = {
        dashboard = {
          enabled = true
        }
      }
      deployment = {
        replicas = var.replicas
        podLabels = {
          app = "traefik"
        }
      }
      metrics = {
        prometheus = {
          service = {
            enabled = var.enable_service_monitor
          }
          serviceMonitor = {
            enabled = var.enable_service_monitor
          }
        }
      }
      additionalArguments = [
        "--serversTransport.insecureSkipVerify=true"
      ]
      logs = {
        access = {
          enabled = true
        }
      }
      tlsOptions = {
        default = {
          minVersion = "VersionTLS12"
        }
      }
      ports = var.enable_https_redirection ? {
        web = {
          redirectTo = {
            port = "websecure"
          }
        }
      } : null
      resources = {
        requests = { for k, v in var.resources.requests : k => v if v != null }
        limits   = { for k, v in var.resources.limits : k => v if v != null }
      }
    }
  }]
}
