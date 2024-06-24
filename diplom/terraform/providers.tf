terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.80"
  
  backend "s3" {
    endpoint   = "https://storage.yandexcloud.net"
    bucket     = "alyoshqa-state-bucket"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YCAJEgIiWipms8KnujZ5B4q_g"
    secret_key = "YCPeDSrXAYMtT_7aH_qLbyV4zBg3PVpIKn7vwaxG"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true 
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}