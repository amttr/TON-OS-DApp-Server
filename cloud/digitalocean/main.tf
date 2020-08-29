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
  public_key = file(var.ssh_pub_key_path)
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