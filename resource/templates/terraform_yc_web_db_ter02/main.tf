resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family =  var.image_family
}

resource "yandex_compute_instance" "web" {
  name        = local.loc_web_name
  platform_id = var.platform_id
  resources {
    cores         = var.vms_resources["vm_web_resources"].vm_cores
    memory        = var.vms_resources["vm_web_resources"].vm_memory
    core_fraction = var.vms_resources["vm_web_resources"].vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_metadata.ssh-keys}"
  }

}

resource "yandex_compute_instance" "db" {
  name        = local.loc_db_name
  platform_id = var.platform_id
  resources {
    cores         = var.vms_resources["vm_db_resources"].vm_cores
    memory        = var.vms_resources["vm_db_resources"].vm_memory
    core_fraction = var.vms_resources["vm_db_resources"].vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_metadata.serial-port-enable
    ssh-keys           = "ubuntu:${var.vms_metadata.ssh-keys}"
  }

}
