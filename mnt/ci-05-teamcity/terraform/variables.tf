variable "token" {
    type = string
}

variable "cloud_id" {
    type = string
}

variable "folder_id" {
    type = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "image" {
  type        = string
  default     = "centos-7"
  description = "Image OS"
}

variable "username" {
  type        = string
  default     = "centos"
  description = "Username on OS"
}

variable "inventory_file" {
  type        = string
  default     = "../infrastructure/inventory/cicd/hosts.yml"
  description = "Inventory file location"
}
