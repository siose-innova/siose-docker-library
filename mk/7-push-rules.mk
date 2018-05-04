
define get-push-rule
## Push one image to DockerHub. Replace $1 by the image name you want to push (e.g. make push-image3).
push-$1: push-$$(imagename_$1)

push-$$(imagename_$1): $(stamps_dir)/built-$$(imagename_$1) $(stamps_dir)/pushed-$$(imagename_$1)

$(stamps_dir)/pushed-$$(imagename_$1): | checkdirs
	@echo 'Login with your Docker ID...'
	@echo 'Remember that VENDOR is $(vendor)'
	@$(DOCKER_LOGIN)
	@echo 'Pushing $1 to DockerHub...'
	@$(DOCKER_PUSH) $1
	@touch $$@

push_targets+= $(stamps_dir)/pushed-$$(imagename_$1)

endef

# push from library to DockerHub
$(foreach x,$(images),\
	$(eval $(call get-push-rule,$(x)))\
)

