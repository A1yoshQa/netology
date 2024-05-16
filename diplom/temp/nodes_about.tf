resource "yandex_compute_instance" "node" {
  count = 3

  name = "node-${count.index + 1}"
  
  resources {
    cores  = 8
    memory = 8
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.[each.id]
    nat = false
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys = local.metadata.ssh-keys
  }

  scheduling_policy {
    preemptible = true
  }
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

locals {
  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}