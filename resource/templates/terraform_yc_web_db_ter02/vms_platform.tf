###unity vms resources
variable "vms_resources" {
  type = map(object({
    vm_cores = string
    vm_memory = string
    vm_core_fraction = string
  }))
  default = {
    "vm_web_resources" = {
      vm_cores = "2"
      vm_memory = "1"
      vm_core_fraction = "5"
    }
    "vm_db_resources" = {
      vm_cores = "2"
      vm_memory = "2"
      vm_core_fraction = "20"
    }
  }
}

###unity metadata
variable "vms_metadata" {
  type = object({
    serial-port-enable = number
    ssh-keys = string
  })
  default = {
	serial-port-enable = 1
	ssh-keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNdZXX1XUJIk37TdoXdDt7gTCtF02BJVhcLu390/iys+wj5QQ1jgCrWk5r6DRvdum6E8U5F8Ddfshm7wbgGVttj2cdHMqK8DiMAUeAW1Kh2bVXiy34QMnH355AzQ/9XmGSTL2w1AdtfbtARhZIkNxT07aEvMjv4ua2C0Nw14oX5t2EEQckQzCAL1+nncoPvJwJBlmt1sVKlGuQtGD+2PnQpdM/Y6sB9ovxlMtxSUvZLXRue9HtcYI+Ctpl24zFcHThpkX2ptCuA7BrZ1Mqc2oN3heRwsFEc+zE2zyXGclMPEJ8/QqjoklPaszVg5VGpyjY1RPWfdxLYa4nTSxkhbxpD0afmS6s6O4nS2hKV6zDvtYzm8FZbpo6UoqvmIwh+klGXp02Psls1dgDG5Peem9kkEnfT2g2UZUY7vTpbKMD+Eneea0gBjZwiATuKj3EJpXGeI/sYFjR6vFH00IWzKtaAF/OgGrMope8ZDqMj2ITtRj8xVZ7lHCQGi/DEim9rj8= root@ubuntu-desktop"
  }
}
