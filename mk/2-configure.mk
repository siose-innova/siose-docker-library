# Based on the Label schema Convention DRAFT (1.0.0-rc.1)
# http://label-schema.org/rc1/
# Use these labels for filtering images created with these metadata
# For example, you can do:
# docker images --filter "label=org.label-schema.vendor=benizar"


# This label contains the Date/Time the image was built. The value SHOULD be formatted according to RFC 3339.
build_date :=$(shell date --rfc-3339=seconds)

# A human friendly name for the image. For example, this could be the name of a microservice in a microservice architecture.
# list all the "docker directories" eg: image1 image2
#names := image3 \
#	image2 \
#	image1 \
#	image4


# Text description of the image. May contain up to 300 characters.
description := This image is part of my docker stack for reproducible research. Check every service README.md to see how I use it.

# Link to a file in the container or alternatively a url that provides usage instructions. If a url is given it SHOULD be specific to this version of the image e.g. http://docs.example.com/v1.2/usage rather than http://docs.example.com/usage
usage := /usr/doc/app-usage.txt

# url of website with more information about the product or service provided by the container.
url := https://github.com/siose-innova/docker-library/blob/master/README.md

# url for the source code under version control from which this container image was built.
vcs_url := https://github.com/siose-innova/siose-docker-library

# Identifier for the version of the source code from which this image was built. For example if the version control system is git this is the SHA.
vcs_ref := $(shell git rev-parse --verify HEAD)

# The organization that produces this image.
vendor := sioseinnova

# The version MAY match a label or tag in the source code repository.
version := 0.1.0

# This label SHOULD be present to indicate the version of Label schema in use.
schema_version := 1.0

