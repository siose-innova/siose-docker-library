
define get-pull-rule
## Pull one single image. Replace $1 by the image name you want to pull (e.g. make pull-alpine..3.7).
pull-$1: $(stamps_dir)/pulled-$1

$(stamps_dir)/pulled-$1: | checkdirs
	@echo 'Pulling $1...'
	$(DOCKER_PULL) $$(subst ..,:,$1)
	@touch $$@

pull_targets+= $(stamps_dir)/pulled-$1

endef

# Pull from DockerHub:
# 1. Official images
# 2. $(vendor) or
$(foreach x,$(from_dockerhub),\
	$(eval $(call get-pull-rule,$(x)))\
)

