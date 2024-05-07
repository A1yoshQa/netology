resource "yandex_iam_service_account" "ig-sa" {
  name        = "alyoshqa-ig"
  description = "Service account for managing the instance group."
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}

resource "yandex_compute_instance_group" "lamp-group" {
  name = "lamp-instance-group"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.network.id}"
      subnet_ids         = ["${yandex_vpc_subnet.public_subnet.id}"]
      nat       = true
    }

    metadata = {
      ssh-keys = "ubuntu:${file(var.public_key)}"
      user-data = "${file("cloud-init.yaml")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["${var.default_zone}"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }
  
  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}