terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
}

module "my-vpc" {
  source = "./vpc"
  env_name = var.env_name
  subnets = var.subnets
}

module "my-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = var.env_name
  network_id      = module.my-vpc.network_id
  subnet_zones    = [ var.default_zone ]
  subnet_ids      = [ module.my-vpc.subnet_ids["${var.default_zone}"] ]
  instance_name   = var.instance_name
  instance_count  = var.instance_count
  image_family    = var.image_family
  public_ip       = var.public_ip
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered
      serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
  
 vars = {
    username           = var.username
    ssh_public_key     = file(var.ssh_public_key)
    packages           = jsonencode(var.packages)
  }
}
