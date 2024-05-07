#cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "nat_instance_image" {
  type    = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat_instance_ip" {
  default     = "192.168.10.254"
  description = "https://yandex.cloud/ru/docs/compute/operations/vm-control/vm-attach-public-ip?utm_referrer"
}

variable "instance_image" {
    type = string
    default = "fd89n8278rhueakslujo"
    description = "yc compute image list --folder-id standard-images"
}

variable "public_key" {
  type        = string
  default     = ("~/.ssh/id_rsa.pub")
  description = "ssh ed25519 public key"
}