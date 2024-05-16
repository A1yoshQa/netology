# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  backend  "s3" {
    endpoints = {
      s3 = "storage.yandexcloud.net"
    }
    bucket = "alyoshqas-bucket"
    region = "ru-central1"
    key    = "terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
    access_key = "ajegkt5h85on6d0blvi5"
    secret_key = "YCAJE3Qv-cW61OyEI-CeEKpN5"
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
