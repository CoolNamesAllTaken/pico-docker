# pico-docker

Setup scripts for creating a docker container with the Raspberry Pi Pico SDK, the relevant ARM compiler, and the JLink debugger utility.

A prebuilt image of this docker container is available on DockerHub at [coolnamesalltaken/pico-docker](https://hub.docker.com/repository/docker/coolnamesalltaken/pico-docker/general).

# Getting Started

## 1. Important Note for Windows Users

Run these commands from the top level directory.

NOTE: Cloning git repos onto windows may result in files with CR+LF line endings. Docker does NOT like these, and they will break everything. Make sure that you set `git config --global core.autocrlf false` before cloning repos that will get added or mounted to a Docker container.


## 2. Set up your docker container

Follow the instructions below for using the pre-built image from dockerhub, or build the image yourself.

### 2A: Use the pre-built Docker image

Run `docker image pull coolnamesalltaken/pico-docker:latest` on your command line to pull the latest pre-built image. If I screwed something up with a recent push to the dockerhub repo, you may want to specify a different tag instead!

### 2B: Build the Docker image yourself

Be sure to run `git submodule update --init --recursive` before building! You may need to change Git's [long filename setting](https://katalon-inc.my.site.com/katalonhelpcenter/s/article/How-to-fix-Git-Clone-Filename-too-long-Error-in-Windows) for this to complete successfully.

From this directory, run the following shell command. This will build the Docker file in the current directory and tag it with the name "pico-docker".

```bash
docker build -t pico-docker --platform linux/amd64 .
```

If you want to output stdout and stderr from the build process to a log file, use the following command instead. Note that the `--no-cache` option will force every build step to rebuild from scratch, which may be helpful if a change to the Dockerfile is not taking effect properly.

```bash
docker build --no-cache --progress=plain -t pico-docker --platform linux/amd64 . &>build.log
```

## 3: Run the Docker Container

Navigate to the directory you would like to bind to the docker container. Use the commands in 3A, 3B, or 3C (depending on your prefernece and operating system) to start the docker container and bind it to your current directory. This will create a container that is bind-mounted to your present working directory, so any files you change in your directory will also be changed in the docker container. If you stop the docker container and start it up again later, it will still be bound to the specified directory.

If you use this docker container for multiple projects, you will end up with a number of different pico-docker containers, each bind-mounted to a separate project directory.

### 3A: Docker Compose

This is the easiest option for running a pico-docker container! Copy `compose.example.yml` into the project folder that you would like to mount to your docker container, and edit it to change where your project will mount to in the container.

Run the docker container by calling `docker compose up` in the directory with the compose YAML file.

### 3B: Running the Docker container manually on Linux or Mac

Start an interactive docker container on Linux or Mac with the command below. Mounts the current directory to `/root/<current directory>`.

```bash
docker run --name pico-docker -it --mount type=bind,source="$(pwd)",target=/root/$(pwd) pico-docker-image
```

### 3C: Running the Docker container manually on Windows

Start an interactive docker container on Windows with the command below. Mounts the current directory to `/root/<current directory>`.

```bash
winpty docker run --name pico-docker -it --mount type=bind,source="$(pwd)",target=/root/$(pwd) pico-docker-image
```

### Develop in the Docker container

Connect to the docker container with VS Code or another IDE and enjoy developing! The environment variable PICO_SDK_PATH should be set, and the Pico SDK should be available at `/usr/local/bin`.