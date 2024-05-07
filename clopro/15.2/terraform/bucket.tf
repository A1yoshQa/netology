// Создание сервисного аккаунта
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name = "alyoshqa-bucket"
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "example_bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "alyoshqas-bucket"

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}

// Добавление объекта в бакет с использованием ключа
resource "yandex_storage_object" "example_object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = yandex_storage_bucket.example_bucket.bucket
  key = "cat.jpg"
  source = "../img/cat.jpg"
}