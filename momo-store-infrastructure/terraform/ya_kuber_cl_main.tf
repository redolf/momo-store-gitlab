resource "yandex_kubernetes_cluster" "k8s-zonal" {
  network_id = yandex_vpc_network.mynet.id
  master {
    version = var.k8s_version
    zonal {
      zone      = yandex_vpc_subnet.mysubnet.zone
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }
    public_ip = true
    security_group_ids = [
      yandex_vpc_security_group.sg-main.id,
      yandex_vpc_security_group.sg-master-api.id
    ]
  }
  service_account_id      = yandex_iam_service_account.myaccount.id
  node_service_account_id = yandex_iam_service_account.myaccount.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]
  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}
