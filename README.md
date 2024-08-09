# dataverse-docker
Towards production ready dataverse docker deployment.

## Introduction
This repository is a collection of scripts and configurations to deploy dataverse in docker environment.

Unlike the official docker project which depends on release images and new docker specified scripts,
this solution only depends on artifacts mention in the official installation guideline and popular base images.
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
./setup.sh  
docker compose up
```

And that's it! You can access the dataverse at `http://localhost:8080`

if you want to clean up and start over, you can run:

```bash
docker compose down
docker container prune
./purge.sh
```
