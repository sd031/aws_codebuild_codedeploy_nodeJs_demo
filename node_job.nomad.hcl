job "node-app-job" {
  type = "service"

  group "group-node-app" {
    count = 1
    network {
      mode = "host"
      port "node_port" {
        #static = 8080
        to = 3000
      }
    }

    service {
      name     = "node-app-svc"
      port     = "node_port"
      provider = "nomad"
    }

    task "node-task" {
      driver = "docker"

      config {
        image = "node_app:v1"
        ports = ["node_port"]
      }
    }
  }
}