# Network
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "public_subnet" {
  name = "public_subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_route_table" "nat-routetable" {
  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_instance_ip
  }
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private_subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.network.id
  route_table_id = yandex_vpc_route_table.nat-routetable.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}