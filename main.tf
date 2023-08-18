provider "helm" {
  kubernetes {
    config_path = "/home/ec2-user/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "/home/ec2-user/.kube/config"
}


resource "kubernetes_namespace" "test-namespace" {
  metadata {
        name = "testing"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  namespace  = "testing"
  chart      = "/root/prometheus-grafana-using-terraform/prometheus"
  set {
    name  = "service.type"
    value = "NodePort"
  }
}

resource "helm_release" "grafana" {
  name       = "grafana"
  namespace  = "testing"
  chart      = "/root/prometheus-grafana-using-terraform/grafana"

  set {
    name  = "service.type"
    value = "NodePort"
  }
}