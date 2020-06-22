job "demo" {
  datacenters = ["dc1"]
  type = "service"
  group "demo" {
    count = 3
    update {
      max_parallel     = 1
      canary           = 1
      min_healthy_time = "30s"
      auto_revert      = true
      auto_promote     = false
    }

    task "bootcamp" {
      driver = "docker"
      config {
        image = "jocatalin/kubernetes-bootcamp:v1"
        port_map {
          http = 8080
        }
      }
      resources {
        network {
          mbits = 10
          port "http" {}
        }
      }
      service {
        name = "bootcamp-demo"
        tags = ["urlprefix-/"]
        port = "http"
        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }
    }
  }
}
