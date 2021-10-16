# doctl compute size list

variable "droplet_region" {
  type = string
  default = "{{ cookiecutter.droplet_region }}"
}

variable "droplet_size" {
  type = string
  default = "{{ cookiecutter.droplet_size }}"
}

variable "droplet_os" {
  type = string
  default = "{{ cookiecutter.droplet_os }}"
}
