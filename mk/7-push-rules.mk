
define get-push-rule
## Push one image to DockerHub. Replace $1 by the image name you want to push (e.g. make push-gdal:2.4.3).
push-$1: $(stamps_dir)/built-$1 $(stamps_dir)/pushed-$1

$(stamps_dir)/pushed-$1: | checkdirs
	@echo 'Tagging a previously built image with "$(vendor)/"...'
	@docker image tag $$(imagename_$1):$$(imagetag_$1) $$(addprefix $(vendor)/,$$(imagename_$1):$$(imagetag_$1))
	@echo 'Login with your Docker ID...'
	@echo 'Remember that VENDOR is $(vendor)'
	@$(DOCKER_LOGIN)
	@echo 'Pushing $1 to DockerHub...'
	@$(DOCKER_PUSH) $$(addprefix $(vendor)/,$$(imagename_$1):$$(imagetag_$1))
	@touch $$@

push_targets+= $(stamps_dir)/pushed-$1

endef

# push from library to DockerHub
$(foreach x,$(images),\
	$(eval $(call get-push-rule,$(x)))\
)

