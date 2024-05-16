resource "yandex_compute_instance" "vms" {
  depends_on = [yandex_compute_instance.node]
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
    nat = each.value.vm_nat
  }
  metadata = {
    serial-port-enable = local.metadata.serial-port-enable
    ssh-keys = local.metadata.ssh-keys
  }
}