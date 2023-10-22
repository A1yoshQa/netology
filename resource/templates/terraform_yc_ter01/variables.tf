# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "YC_CLOUD_ID" {
  default = "тут нужно вставить значение"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "YC_FOLDER_ID" {
  default = "тут нужно вставить значение"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "ubuntu-toolbox-server" {
  default = "тут нужно вставить значение"
}
