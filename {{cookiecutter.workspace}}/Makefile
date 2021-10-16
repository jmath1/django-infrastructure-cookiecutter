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
	./ansible/utils/generate_inventory.py
