To use this cookiecutter, just download the cookiecutter python3 package and run:

`cookiecutter  https://github.com/jmath1/django-infrastructure-cookiecutter.git`

Follow the command prompt to create the end result. cd into the workspace (that you entered into the prompt), and run `make compose` to build locally.

To deploy to the cloud, you must have enterred a Digital Ocean api key when initializing the cookie cutter. If you didn't do that, just copy it to a file called `./keys/digital_ocean.token` in the repo. AWS keys are not necessary unless you want to store the terraform state in S3. In the future there will be support for EC2 instances so this is not only limited to Digital Ocean.

Run the terraform configuration and set up the root user by running `make setup`.

** Before running `make app`, make sure to run `make git` so you are not deploying your API keys. **

To run the deployment, run `make app`.

*** TODO ***
* Nginx static files issue
* Make a way to test this cookiecutter quickly
* Make a CLI so users can have an easier time going through the cookie-cutter customization process. This would increase cookiecutter flexibility in terms of customization.
* Make command for easy ssh access
* Add terraform configuration and cookiecutter template a provisioned database instead of a docker container database
* Add support for AWS EC2
* Grafana/Prometheus Implementation for application monitoring via Ansible and Docker-Compose
* Deploy across multiple servers and use Consul to connect the containers
* Automated SSL implementation via ansible. Would require user input for domain name since domains cannot be provisioned via terraform.
* Better security with Ansible Vault