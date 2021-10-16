#!/usr/bin/env python

import subprocess


TOKEN_FILE = "./keys/digital_ocean.token"

try:
    api_token = open(TOKEN_FILE, 'r').read().strip()
except IOError:
    print(f" ---> Missing Digital Ocean API token: {TOKEN_FILE}")
    exit()

outfile = f"./ansible/inventories/digital_ocean.ini"

# Install from https://github.com/do-community/do-ansible-inventory/releases
ansible_inventory_cmd = f'do-ansible-inventory -t {api_token} --out {outfile}'
subprocess.call(ansible_inventory_cmd, shell=True)

exit()