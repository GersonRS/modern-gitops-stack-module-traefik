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
            enabled       = var.enable_service_monitor
            namespace     = var.namespace
            interval      = "30s"
            scrapeTimeout = "10s"
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
      providers = {
        kubernetesIngress = {
          publishedService = {
            enabled = true
          }
        }
      }
      ports = var.enable_https_redirection ? {
        web = {
          http = {
            redirections = {
              entryPoint = {
                to        = "websecure"
                scheme    = "https"
                permanent = true
              }
            }
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
