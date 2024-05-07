#Public-instance:
resource "yandex_compute_instance" "public-instance" {
  platform_id = "standard-v3"
  name        = "public-instance"
  zone        = var.default_zone
  description = "https://terraform-provider.yandexcloud.net/Resources/compute_image"
  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = var.instance_image
      name     = "public-instance"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public_subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }
}