git:
	- git init
	- echo "keys/" | tee .gitignore
requirements:
	- python3 -m virtualenv venv
	- . venv/bin/activate
	- pip3 install -r requirements.txt
	- . install_do_inventory.sh
compose:
	docker-compose up -d
# Digital Ocean / Terraform
init:
	terraform -chdir=terraform init
tfrefresh:
	terraform -chdir=terraform refresh
plan:
	terraform -chdir=terraform plan -refresh=false
apply:
	terraform -chdir=terraform apply -refresh=false -parallelism=15
inventory:
	- make requirements
	- ./ansible/utils/generate_inventory.py
terraform:
	- make apply
	- make inventory
app:
	- make terraform
	- ansible-playbook -l {{ cookiecutter.droplet_name }} ansible/playbooks/setup_root.yml
	- ansible-playbook -l {{ cookiecutter.droplet_name }} ansible/playbooks/setup_app.yml
  
