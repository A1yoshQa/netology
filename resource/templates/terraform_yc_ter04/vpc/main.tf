terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_vpc_network" "develop" {
  name = "${var.env_name}"
}

resource "yandex_vpc_subnet" "develop" {
  for_each = {
    for k,v in var.subnets :
      v.zone => v
  }
  name           = "develop-${each.value.zone}"
  zone           = "${each.value.zone}"
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["${each.value.cidr}"]
}
