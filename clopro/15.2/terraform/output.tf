output "internal_ip_address_nat-instance_yandex_cloud" {
  value = "${yandex_compute_instance.nat-instance.network_interface.0.ip_address}"
}

output "external_ip_address_nat-instance_yandex_cloud" {
  value = "${yandex_compute_instance.nat-instance.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_public-instance_yandex_cloud" {
  value = "${yandex_compute_instance.public-instance.network_interface.0.ip_address}"
}

output "external_ip_address_public-instance_yandex_cloud" {
  value = "${yandex_compute_instance.public-instance.network_interface.0.nat_ip_address}"
}

output "internal_ip_address_private-instance_yandex_cloud" {
  value = "${yandex_compute_instance.private-instance.network_interface.0.ip_address}"
}
