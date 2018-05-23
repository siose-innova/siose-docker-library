
include $(sort $(wildcard mk/*.mk))


## Build and push all images to the registry.
all: pull build push

## Build all images locally.
build: $(build_targets)

## Pull all required images from the registry.
pull: $(pull_targets)

## Push all images to the registry.
push: $(push_targets)

## Clean images built by this Makefile.
clean: $(clean_targets)


## Clean images pushed by this Makefile. However, there is no need to delete official images, since they could have existed anyway.
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
	@echo 'TODO: This should rmi the most superficial images in the tree (leaves). For example, remove siose-2005, but keep postgis and postgres database. Do the same for other "leaves".'

## Cleans almost everything that can be reconstructed with this Makefile (e.g. official images, base images, cache, logfiles, etc).
maintainers-clean: distclean clean
ifneq (,$(pulled_stamps))
	@echo "Cleaning stamps for images pulled from DockerHub..."
	@$(DOCKER_RMI) $(subst ..,:,$(pulled))
	@$(RM) $(pulled_stamps)
else
	@echo "Nothing to be done."
endif



