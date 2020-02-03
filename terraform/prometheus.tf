resource "helm_release" "prometheus" {
    name      = "prometheus"
    chart     = "stable/prometheus"
    namespace = "prometheus"

    set {
        name  = "admin"
        value = "admin"
    }

    set {
        name = "password"
        value = "qwerew"
    }

    set_string {
        name = "image.tags"
        value = "registry\\.io/terraform-provider-helm\\,example\\.io/terraform-provider-helm"
    }
}
