resource "yandex_lb_network_load_balancer" "foo" {
  name = "buckats"
  listener {
    name = "load-balancer-bucket"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = "enp773kdgn593ar95oi2"
    healthcheck {
      name = "catsalive"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
