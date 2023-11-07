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
  family = "ubuntu-2004-lts"
}


resource "yandex_compute_instance" "vms" {
  for_each = var.vms
  name = each.value.vm_name
  platform_id = var.platform_id

  resources {
    cores = each.value.vm_cores
    memory = each.value.vm_memory
    core_fraction = each.value.vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = each.value.vm_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }
  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys = local.metadata.ssh-keys
  }
}
