
define get-clean-rule

.PHONY:clean-$1
## Clean one single image, if it was created by this makefile. Replace $1 by the image name you want to remove (e.g. make clean-alpine-bash..3.4).
clean-$1:
	@echo 'Cleaning $1...'
	@$(DOCKER_RMI) $$(subst ..,:,$1) && rm $(stamps_dir)/built-$1 && rm $(stamps_dir)/pushed-$1

clean_targets+= clean-$1

endef


$(foreach x,$(built),\
	$(eval $(call get-clean-rule,$(x)))\
)


# Refs:
# - https://www.calazan.com/docker-cleanup-commands/
# - http://stackoverflow.com/questions/17236796/how-to-remove-old-docker-containers
#	@echo "Remove all non running containers"
#	-docker rm `docker ps -q -f status=exited`
#	@echo "Delete all untagged/dangling (<none>) images"
#	-docker rmi `docker images -q -f dangling=true`

