# dataverse-docker
Towards production ready dataverse docker deployment.

## Introduction
This repository is a collection of scripts and configurations to deploy dataverse in docker environment.

Unlike the official docker project which depends on customized images and docker specified scripts,
this solution only depends on artifacts mentioned in the official installation guideline and popular docker base images.
This project contains all you need to customize and deploy dataverse in docker environment.

If you are already familiar with the official installation, you will find it easy to migrate to this solution.
Or you can use this as a test environment to try out the dataverse options before you apply them to your running service.

## Getting Started

### Download the installation package
You need to download the following files according to the [official installation guide](http://guides.dataverse.org/en/6.3/installation/prerequisites.html):

* dvinstall.zip

#### For 6.3, 6.2:
* payara-6.2024.6.zip 
* counter-processor-0.1.04.tar.gz
* GeoLite2-Country_20240806.tar.gz

Please download these files and put them in the `download` directory.

### Build the images
```bash
cp docker-compose.yml.dist docker-compose.yml

# edit docker-compose.yml to set passwords and other configurations

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

And that's it! You can access the dataverse at `http://localhost:8080` after waiting for a few minutes.

if you want to clean up and start over, you can run:

```bash
docker compose down
docker container prune
./purge.sh
```

## Advanced Configuration
All configuration options can be found in https://guides.dataverse.org/en/6.2/installation/config.html#jvm-options

### Automatic configuration
If you want to automatically configure the dataverse, you can create a script and mount it to the container's `/mnt/dv-config`, you can use the `dv-config.dist` as a start point.

Don't forget to grant the script execution permission by running `chmod +x dv-config`.

## FAQ

### Fix broken Chinese characters

If you have chinese characters in your custom page, you need to add the following jvm option to the payara server:
```bash
/usr/local/payara6/bin/asadmin create-jvm-options "-Dfile.encoding=UTF8"    
```

## Examples
* https://dataverse.ikkem.com - A production ready dataverse deployment using this project.