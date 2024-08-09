# dataverse-docker
Towards production ready dataverse docker deployment.

## Introduction
This repository is a collection of scripts and configurations to deploy dataverse in docker environment.

Unlike the official docker project which depends on customized images and docker specified scripts,
this solution only depends on artifacts mentioned in the official installation guideline and popular docker base images.
If you are already familiar with the official installation guide, you can easily customize this deployment.

## Getting Started

### Download the installation package

You need to download the following files according to the [official installation guide](http://guides.dataverse.org/en/6.3/installation/prerequisites.html):

* dvinstall.zip

#### For 6.3, 6.2:
* counter-processor-0.1.04.tar.gz
* GeoLite2-Country_20240806.tar.gz
* payara-6.2024.6.zip 

Please download these files and put them in the `download` directory.

### Build the images

```bash
docker compose build
```

### Start the services

```bash
# unzip the installation package to dvinstall directory
unzip download/dvinstall-6.3.zip

# edit default.config and docker-compose.yml to set passwords and other configurations
# and then copy the configuration to dvinstall directory
cp default.config dvinstall

# run extra setup
./setup.sh  

# start the services
docker compose up
```

And that's it! You can access the dataverse at `http://localhost:8080`

if you want to clean up and start over, you can run:

```bash
docker compose down
docker container prune
./purge.sh
```
