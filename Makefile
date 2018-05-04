include mk/1*.mk
include mk/2*.mk
include mk/3*.mk
include mk/4*.mk
include mk/5*.mk
include mk/6*.mk
include mk/7*.mk
include mk/8*.mk

## Build and push all images to the registry.
all: pull-all build-all push-all

## Build all images locally.
build-all: $(build_targets)

## Pull all required images from the registry.
pull-all: $(pull_targets)
	@echo "Pulling all required images..."

## Push all images to the registry.
push-all: $(push_targets)
	@echo "Pushing all images..."

## Clean images built by this Makefile.
clean: $(clean_targets)
	@echo "Cleaning stamps and images built by this Makefile..."

## Clean images built or pulled by this Makefile. However, there is no need to delete official images, since they could have existed anyway.
distclean:
ifneq (,$(pushed_stamps))
	@echo "Cleaning stamps for images pushed to DockerHub..."
	@$(RM) $(pushed_stamps)
else
	@echo "Nothing was pushed or there are no stamp files of pushed images."
endif

## Like ‘Clean’, but keep a few files that people normally don’t want to recompile (e.g. official images, base images, cache, logfiles, etc).
mostly-clean: clean
	@echo 'TODO: Separate official images, base images and others downloaded from DH'

## Cleans almost everything that can be reconstructed with this Makefile (e.g. official images, base images, cache, logfiles, etc).
maintainers-clean: distclean clean
ifneq (,$(pulled_stamps))
	@echo "Cleaning stamps for images pulled from DockerHub..."
	@$(DOCKER_RMI) $(pulled)
	@$(RM) $(pulled_stamps)
else
	@echo "Nothing to be done."
endif



