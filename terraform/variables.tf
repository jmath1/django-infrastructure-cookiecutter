# doctl compute size list

variable "droplet_region" {
  type = string
  default = "{{ droplet_region }}"
}

variable "droplet_size" {
  type = string
  default = "{{ droplet_size }}"
}

variable "droplet_os" {
  type = string
  default = "{{ droplet_os }}"
}
