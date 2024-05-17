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
}

variable "platform_id" {
  default     = "standard-v1"
}

variable "vms" {
  type = map(object({ 
    vm_name = string, 
    vm_cores = number,
    vm_memory = number,
    vm_size = number,
    vm_core_fraction = number,
    nat = bool
  }))
  default = { 
     vm1 = {
      vm_name = "master",
      vm_cores = 4,
      vm_memory = 4,
      vm_size = 100,
      vm_core_fraction = 100,
      nat = true
    },
     vm2 = {
      vm_name = "monitoring",
      vm_cores = 4,
      vm_memory = 4,
      vm_size = 100,
      vm_core_fraction = 100,
      nat = true
    }
  }
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