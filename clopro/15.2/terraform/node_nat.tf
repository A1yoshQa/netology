#NAT-instance:
resource "yandex_compute_instance" "nat-instance" {
  platform_id = "standard-v3"
  name        = "nat-instance"
  zone        = var.default_zone
  description = "https://terraform-provider.yandexcloud.net/Resources/compute_image"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.nat_instance_image
      name     = "nat-instance"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id  = yandex_vpc_subnet.public_subnet.id
    nat        = true
    ip_address = var.nat_instance_ip
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }
}