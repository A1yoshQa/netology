output "internal_ip_address_node00" {
  value = "${yandex_compute_instance.master01.network_interface.0.ip_address}"
}

output "external_ip_address_node00" {
  value = "${yandex_compute_instance.master01.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node01" {
  value = "${yandex_compute_instance.worker01.network_interface.0.ip_address}"
}

output "external_ip_address_node01" {
  value = "${yandex_compute_instance.worker01.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node02" {
  value = "${yandex_compute_instance.worker02.network_interface.0.ip_address}"
}

output "external_ip_address_node02" {
  value = "${yandex_compute_instance.worker02.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node03" {
  value = "${yandex_compute_instance.worker03.network_interface.0.ip_address}"
}

output "external_ip_address_node03" {
  value = "${yandex_compute_instance.worker03.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_node04" {
  value = "${yandex_compute_instance.worker04.network_interface.0.ip_address}"
}

output "external_ip_address_node04" {
  value = "${yandex_compute_instance.worker04.network_interface.0.nat_ip_address}"
}

