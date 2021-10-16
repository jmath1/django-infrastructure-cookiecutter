terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.22.2"
    }
  }
  {% if cookiecutter.s3_state_storage %}
  backend "s3" {
    bucket = "{{ cookiecutter.project_name }}.terraform"
    key    = "{{ cookiecutter.project_name }}.terraform.tfstate"
    region = "us-east-1"
    shared_credentials_file = "./keys/aws.s3.token"
  }
  {% endif %}
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

resource "digitalocean_droplet" "{{ cookiecutter.droplet_name }}" {
  count    = 3
  image    = var.droplet_os
  name     = "db-consul${count.index+1}"
  region   = var.droplet_region
  size     = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  {% if cookiecutter.add_volume %}
  volume_ids = [digitalocean_volume.{{ cookiecutter.volume_name }}.id]
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

{% if cookiecutter.add_volume %}
resource "digitalocean_volume" "{{ cookiecutter.volume_name }}" {
  count                   = 0
  region                  = "nyc1"
  name                    = "{{ cookiecutter.volume_name }}"
  size                    = 100
  initial_filesystem_type = "ext4"
  description             = "My volume"
}
{% endif %}
