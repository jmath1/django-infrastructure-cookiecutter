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
	- mkdir ./ansible/inventories/
	- python ./ansible/utils/generate_inventory.py
tf:
	- make apply
	- make inventory
setup:
	- make tf
	- ansible-playbook -l {{ cookiecutter.droplet_name }} ansible/playbooks/setup_root.yml

app:
	- make setup
	- make deploy
  
deploy:
	- ansible-playbook -l {{ cookiecutter.droplet_name }} ansible/playbooks/setup_app.yml

ssh:
	- ssh root@137.184.133.147 -i ~/.ssh/id_rsa

