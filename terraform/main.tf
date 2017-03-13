# Create a new tag
resource "digitalocean_tag" "cluster_tag" {
  name = "${var.cluster_tag}"
}

# Upload SSH key which all instances will use.
resource "digitalocean_ssh_key" "default" {
  name       = "SSH Key for Terraform"
  public_key = "${file("${path.module}/ssh/cluster.pem.pub")}"
}

# Set the userdata script to be the openvpn file.
resource "template_file" "openvpn_userdata" {
  template = "openvpn.yml"
}

# Create a VPN node
resource "digitalocean_droplet" "vpn" {
  image              = "${var.image}"
  name               = "vpn"
  region             = "${var.region}"
  size               = "${var.droplet_size}"
  ssh_keys           = ["${digitalocean_ssh_key.default.id}"]
  tags               = ["${digitalocean_tag.cluster_tag.id}"]
  user_data          = "${template_file.openvpn_userdata.rendered}"
  private_networking = true
}
