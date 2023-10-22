output "external_ip_web" {
  value = yandex_compute_instance.web.*.network_interface.0.nat_ip_address
}

output "external_ip_db" {
  value = yandex_compute_instance.db.*.network_interface.0.nat_ip_address
}
