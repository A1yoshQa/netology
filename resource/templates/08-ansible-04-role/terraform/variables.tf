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
variable "platform_id" {
  type        = string
  default     = "standard-v1"
}

###vms names&resources
variable "vms" {
  type = map(object({ 
    vm_name = string, 
    vm_cores = number,
    vm_memory = number,
    vm_size = number,
    vm_core_fraction = number 
  }))
  default = { 
     vm1 = {
      vm_name = "clickhouse",
      vm_cores = 2,
      vm_memory = 2,
      vm_size = 10,
      vm_core_fraction = 20
    },
     vm2 = {
      vm_name = "vector",
      vm_cores = 2,
      vm_memory = 2,
      vm_size = 10,
      vm_core_fraction = 20
    },
     vm3 = {
      vm_name = "lighthouse",
      vm_cores = 2,
      vm_memory = 2,
      vm_size = 10,
      vm_core_fraction = 20
    }
  }
}
