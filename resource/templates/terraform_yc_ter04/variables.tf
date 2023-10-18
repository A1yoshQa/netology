###cloud vars
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
###vms vars
variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = string
  default     = "10.0.1.0/24"
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "env_name" {
  type = string
  default = "develop"
}

variable "instance_name" {
  type = string
  default = "web"
}

variable "instance_count" {
  type = number
  default = 3
}

variable "image_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "public_ip" {
  type = bool
  default = true
}

###cloud-init vars
variable "username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_public_key" {
  type    = string
  default = ("~/.ssh/id_rsa.pub")
}

variable "packages" {
  type    = list(string)
  default = ["vim", "nginx"]
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}
