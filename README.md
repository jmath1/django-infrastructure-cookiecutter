To use this cookiecutter, just download the cookiecutter python3 package and run:

`cookiecutter  https://github.com/jmath1/docker-compose-django-nginx-cookiecutter.git`

Follow the command prompt to create the end result. cd into the workspace (that you entered into the prompt), and run `make compose` to build locally.

To deploy to the cloud, you must have enterred a Digital Ocean api key when initializing the cookie cutter. If you didn't do that, just copy it to a file called `./keys/digital_ocean.token` in the repo. To run the deployment, run `make app`.