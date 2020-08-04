variable "gcp_region" {
  type    = string
  default = "europe-west3"
}

variable "gcp_zone" {
  type    = string
  default = "europe-west3-b"
}

variable "gcp_project" {
  type    = string
  default = "cs-k8s"
}

variable "machine_type" {
  type    = string
  default = "e2-highcpu-4"
}

variable "gcp_image" {
  type = string
  default = "rancher-k3os-v0-11-0-b202008021203"
}

variable "github_user" {
  type = string
  default = "lalyos"
}
variable "k3os_password" {
  type = string
  default = "rancher"
}
variable "k3os_token" {
  type = string
  default = "s3cr3t0k3n"
}

variable "ssh_key" {
  type = string
}
