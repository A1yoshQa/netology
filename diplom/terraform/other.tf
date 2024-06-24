resource "yandex_iam_service_account" "k8s-sa" {
  folder_id = var.folder_id
  name      = "terraform-service-account"
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-editor" {
  folder_id = var.folder_id
  role      = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
  ]
  depends_on = [
    yandex_iam_service_account.k8s-sa
  ]
}

resource "yandex_resourcemanager_folder_iam_binding" "k8s-images-puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
  ]
  depends_on = [
    yandex_iam_service_account.k8s-sa
  ]
}

resource "local_file" "k8s_hosts_ip" {
  content = <<-DOC
---
all:
  hosts:
%{ for instance in yandex_compute_instance.k8s-control-plane }
    control-plane-${index(yandex_compute_instance.k8s-control-plane, instance) + 1}:
      ansible_host: ${instance.network_interface[0].nat_ip_address}
      ansible_user: ubuntu
%{ endfor }
%{ for instance in yandex_compute_instance_group.k8s-node-group.instances }
    node-${index(yandex_compute_instance_group.k8s-node-group.instances, instance) + 1}:
      ansible_host: ${instance.network_interface[0].nat_ip_address}
      ansible_user: ubuntu
%{ endfor }
  children:
    kube_control_plane:
      hosts:
%{ for instance in yandex_compute_instance.k8s-control-plane }
        control-plane-${index(yandex_compute_instance.k8s-control-plane, instance) + 1}:
%{ endfor }
    kube_node:
      hosts:
%{ for instance in yandex_compute_instance_group.k8s-node-group.instances }
        node-${index(yandex_compute_instance_group.k8s-node-group.instances, instance) + 1}:
%{ endfor }
    etcd:
      hosts:
%{ for instance in yandex_compute_instance.k8s-control-plane }
        control-plane-${index(yandex_compute_instance.k8s-control-plane, instance) + 1}:
%{ endfor }
    k8s_cluster:
      vars:
        supplementary_addresses_in_ssl_keys: [
%{ for instance in yandex_compute_instance.k8s-control-plane }
          ${instance.network_interface[0].nat_ip_address},
%{ endfor }
        ]
      children:
        kube_control_plane:
        kube_node:
    calico_rr:
      hosts: {}
  DOC
  filename = "../kubespray/inventory/my-k8s-cluster/hosts.yml"
}