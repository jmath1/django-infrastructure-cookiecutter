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
destroy:
	terraform -chdir=terraform destroy

# generates ansible inventory using python script
inventory:
	- make requirements
	- mkdir ./ansible/inventories/
	- python ./ansible/utils/generate_inventory.py
tf:
	- terraform -chdir=terraform init
	- make apply
	- make inventory

# set up infrastructure and root user
setup:
	- make tf
	- ansible-playbook -i ansible/inventories/digital_ocean.ini -l mydroplet ansible/playbooks/setup_root.yml

# set up infrastructure, root user, and deploy application code
app:
	- make setup
	- make deploy
  
# deploy application code
deploy:
	- ansible-playbook -i ansible/inventories/digital_ocean.ini -l {{ cookiecutter.droplet_name }} ansible/playbooks/setup_app.yml
