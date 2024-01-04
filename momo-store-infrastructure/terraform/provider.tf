provider "yandex" {
  service_account_key_file = "/home/redolf/key.json"
  folder_id                = var.folder_id
  cloud_id                 = var.cloud_id
  zone                     = var.zone
}
