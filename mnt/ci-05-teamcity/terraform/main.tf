terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}


resource "yandex_compute_instance" "nexus" {
  name = "nexus"

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 5
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
    }
  }
    
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

}

data "yandex_compute_image" "image" {
  family = "${var.image}"
}

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "local_file" "hosts" { 
  content = templatefile("./hosts.tftpl", {
    nexus = yandex_compute_instance.nexus.network_interface.0.nat_ip_address
  })
  filename = var.inventory_file
}
