variable "nlb_id" {
  description = "ID of the Exoscale NLB to use for the SKS cluster."
  type        = string
}

variable "router_nodepool_id" {
  description = "ID of the node pool specifically created for Traefik."
  type        = string
}

variable "router_instance_pool_id" {
  description = "Instance pool ID of the node pool specifically created for Traefik."
  type        = string
}
