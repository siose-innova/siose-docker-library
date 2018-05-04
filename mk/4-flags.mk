# SHELL needed?
SHELL = /bin/sh
RM = rm

# DOCKER
DOCKER       ?= docker

DOCKER_RMI   := $(DOCKER) rmi
DOCKER_BUILD := $(DOCKER) build --rm --force-rm
DOCKER_PUSH  := $(DOCKER) push
DOCKER_PULL  := $(DOCKER) pull

DOCKER_IMAGES        := $(DOCKER) images
DOCKER_IMAGES_FILTER := $(DOCKER_IMAGES) --filter

DOCKER_LOGIN := $(DOCKER) login

