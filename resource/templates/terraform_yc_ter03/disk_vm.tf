resource "yandex_compute_disk" "disks" {
  count = 3
  name  = "disk-${count.index}"
  size = 1

  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "storage" {
  depends_on = [yandex_compute_disk.disks]
  name = "storage"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat  = true
  }

  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys           = local.metadata.ssh-keys
  }

  scheduling_policy {
    preemptible = true
  }
 
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
