env = "prod"

components = {

  frontend = {
    name          = "frontend"
    instance_type = "t3.medium"
    port_no       = 80
  }

  mysql = {
    name          = "mysql"
    instance_type = "t3.micro"
    port_no       = 3306
  }

  backend = {
    name          = "backend"
    instance_type = "t3.medium"
    port_no       = 8080
  }
}