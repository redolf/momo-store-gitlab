resource "yandex_kubernetes_node_group" "ng-worker" {
  cluster_id = yandex_kubernetes_cluster.k8s-zonal.id

  instance_template {

    platform_id               = "standard-v1"
    network_acceleration_type = "standard"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.mysubnet.id}"]
      security_group_ids = [
        yandex_vpc_security_group.sg-main.id,
        yandex_vpc_security_group.sg-nodes-ssh.id,
        yandex_vpc_security_group.sg-public-services.id
      ]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

}