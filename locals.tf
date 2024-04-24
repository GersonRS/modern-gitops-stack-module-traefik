locals {
  helm_values = [{
    traefik = {
      deployment = {
        replicas = var.replicas
      }
      metrics = {
        prometheus = {
          service = {
            enabled = true
          }
          serviceMonitor = var.enable_service_monitor ? {
            # Dummy attribute to make serviceMonitor evaluate to true in a condition in the Helm chart
            foo = "bar"
          } : {}
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
