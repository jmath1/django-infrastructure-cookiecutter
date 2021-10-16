compose:
	docker-compose up -d
# Digital Ocean / Terraform
tfrefresh:
	terraform -chdir=terraform refresh
plan:
	terraform -chdir=terraform plan -refresh=false
apply:
	terraform -chdir=terraform apply -refresh=false -parallelism=15
inventory:
	./ansible/utils/generate_inventory.py
