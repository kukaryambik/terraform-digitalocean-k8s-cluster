name               = "test"
region             = "ams3"
kubernetes_version = "1.24.12-do.0"
node_pools = [{
  default    = true
  name       = "test"
  size       = "s-1vcpu-2gb"
  node_count = 1
}]
