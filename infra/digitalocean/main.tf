terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "tonos" {
  name       = "tonos"
  public_key = file("${var.user_ssh_id_path}.pub")
}

resource "digitalocean_droplet" "tonos" {
  name     = "tonos"
  image    = var.image
  region   = var.region
  size     = var.size
  ssh_keys = [digitalocean_ssh_key.tonos.fingerprint]
}

resource "digitalocean_project" "tonos" {
  name        = "tonos"
  description = "TON OS DApp Server"
  environment = "Production"
  resources = [
    digitalocean_droplet.tonos.urn
  ]
}

resource "local_file" "inventory" {
  content = templatefile("${path.module}/../templates/inventory.tpl",
    {
      tonos_ip        = digitalocean_droplet.tonos.ipv4_address
      tonos_user      = "root"
      git_ssh_id_path = var.git_ssh_id_path
    }
  )
  filename = "${path.module}/../../ansible/inventory"
}

#resource "null_resource" "delay" {
#  provisioner "local-exec" {
#    command = "sleep 120s"
#  }
#}

#resource "null_resource" "provision" {
#  provisioner "local-exec" {
#    working_dir = "../../ansible"
#    command     = "ansible-playbook -v playbooks/provision.yml"
#  }
#  depends_on = [null_resource.delay]
#}
