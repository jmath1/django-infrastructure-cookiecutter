terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }

  backend "s3" {
    bucket = "{{ project_name }}.terraform"
    key    = "{{ project_name }}.terraform.tfstate"
    region = "us-east-1"
    shared_credentials_file = "./keys/aws.s3.token"
  }
}

provider "digitalocean" {
  token = trimspace(file("./keys/digital_ocean.token"))
}

resource "digitalocean_ssh_key" "default" {
  name       = "MY_SSH_KEY"
  public_key = file("~/id_rsa.pub")
}

# #################
# #   Resources   #
# #################

resource "digitalocean_droplet" "{{ droplet_name }}" {
  count    = 3
  image    = var.droplet_os
  name     = "db-consul${count.index+1}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  {% if add_volume %}
  volume_ids = [digitalocean_volume.{{ volume_name }}.id]
  {% endif %}
  provisioner "local-exec" {
    command = "./ansible/utils/generate_inventory.py; sleep 120"
  }
  provisioner "local-exec" {
    command = "cd ..; ansible-playbook -l ${self.name} ansible/playbooks/setup_root.yml"
  }
  provisioner "local-exec" {
    command = "cd ..; ansible-playbook -l ${self.name} ansible/setup.yml"
  }
}

{% if add_volume %}
resource "digitalocean_volume" "{{ volume_name }}" {
  count                   = 0
  region                  = "nyc1"
  name                    = "{{ volume_name }}"
  size                    = 100
  initial_filesystem_type = "ext4"
  description             = "My volume"
}
{% endif %}
