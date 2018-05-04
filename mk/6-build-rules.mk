
define get-build-rule
## Build one single image and its dependencies. Replace $1 by the image name you want to build (e.g. make build-image3).
build-$1: build-$$(imagename_$1)

build-$$(imagename_$1): $(stamps_dir)/built-$$(imagename_$1)

ifneq (,$$(filter $$(from_$1),$(from_library)))
# Found in this lib
$(stamps_dir)/built-$$(imagename_$1): $(stamps_dir)/built-$$(notdir $$(from_$1)) $$(dockerfile_$1) | checkdirs
else
# Not found in this lib, so pull it first.
$(stamps_dir)/built-$$(imagename_$1): $(stamps_dir)/pulled-$$(from_$1) $$(dockerfile_$1) | checkdirs
endif
	@echo 'Building $1...'
	@$(DOCKER_BUILD) \
		-t $1:$(version) \
		-t $1:latest \
		--label org.label-schema.build-date="$(build_date)" \
		--label org.label-schema.name=$$(imagename_$1) \
		--label org.label-schema.description="$(description)" \
		--label org.label-schema.usage="$(usage)" \
		--label org.label-schema.url="$(url)" \
		--label org.label-schema.vcs-url="$(vcs_url)" \
		--label org.label-schema.vcs-ref="$(vcs_ref)" \
		--label org.label-schema.vendor="$(vendor)" \
		--label org.label-schema.version="$(version)" \
		--label org.label-schema.schema-version="$(schema_version)" \
		$(lib_dir)/$$(imagename_$1) # dockerfile context (its folder's name)
	@touch $$@

build_targets+= $(stamps_dir)/built-$$(imagename_$1)

endef


$(foreach x,$(images),\
	$(eval $(call get-build-rule,$(x)))\
)

