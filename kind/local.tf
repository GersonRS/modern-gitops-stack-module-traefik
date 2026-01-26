locals {
  nameOverride = "traefik"
  helm_values = [{
    traefik = {}
  }]
}
