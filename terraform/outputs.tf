output "droplet_ip" {
  value = "${digitalocean_droplet.vpn.ipv4_address}"
}
