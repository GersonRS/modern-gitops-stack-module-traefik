locals {
  helm_values = [{
    traefik = {
      ports = {
        web = {
          hostPort = 80
        }
        websecure = {
          hostPort = 443
        }
      }
      service = {
        type = "ClusterIP"
      }
    }
  }]
}
