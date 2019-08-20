# Configure the Docker provider
provider "docker" {
  host = "tcp://127.0.0.1:2376/"
}

# Create a container
resource "docker_container" "slave" {
  name  = "JenkinsSlave"
  image = "liveforensics/jenkinswindowsslave:1903"
  restart = "always"
  memory = 2000
  env = ["JENKINS_URL=http://dockerdude.ukwest.cloudapp.azure.com:10008/computer/DockerTwo/slave-agent.jnlp", "JENKINS_SECRET=e2d90db5820bae44edc0d515914e90eade8f129962a8d330d4ae9071cab04a3f"]
}

# create wordpress container
# resource "docker_container" "wordpress" {
#   name  = "wordpress"
#   image = "wordpress:latest"
#   restart = "always"
#   # ports = {
#   #   internal = "80"
#   #   external = "8080"
#   # }
# }