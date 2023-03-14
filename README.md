## Terraform work environment
This repository was made to make terraform easy to use and practice for novice developers, such as myself :)

### Prerequisites
Make sure you have docker installed on your host system. If on windows, install "docker desktop" and run from WSL. If on linux, follow the instructions in the documentation.
Also, make sure you have python installed. I specified my own python version in the Pipfile, but feel free to edit the version to your own.

Make sure you have pipenv installed. If you don't, install it with pip.

### Installation
Use `pipenv install` to install all requirements to a virtual environment. Use `pipenv shell` to activate this environment.
Once in the shell, use `docker compose up` to setup the work environment.

### Usage
To use the environment's shell, you should attach your shell to the container. Use `docker exec -it CONTAINER_ID /bin/bash` or better yet, your IDE's features, to do so.

The container is linked through a volume to the `src` directory. Use it to play with your manifests.

Any resources made with the "docker" provider will use the host docker daemon (through a volume to the docker.sock file).