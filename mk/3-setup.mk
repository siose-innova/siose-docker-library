#-----------------------------
# DIRECTORY STRUCTURE (PATHS)
#-----------------------------
lib_dir     := lib

log_dir     := logs
stamps_dir  := stamps
dirs        := $(log_dir) $(stamps_dir)

# Target for creating all necessary folders
checkdirs: $(dirs)
$(dirs):
	mkdir -p $@

dockerfiles := $(wildcard $(lib_dir)/*/*/Dockerfile) # lib/name/tag/Dockerfile
names       := $(patsubst $(lib_dir)/%/Dockerfile,%,$(dockerfiles)) # name/tag
#images_long := $(addprefix $(vendor)/,$(names)) #vendor/name/tag
images      := $(subst /,..,$(names)) #name..tag


# Stamp files for cleaning targets
built_stamps  := $(wildcard $(stamps_dir)/built-*)
pulled_stamps := $(wildcard $(stamps_dir)/pulled-*)
pushed_stamps := $(wildcard $(stamps_dir)/pushed-*)

built  := $(patsubst $(stamps_dir)/built-%,%,$(built_stamps))
pulled := $(patsubst $(stamps_dir)/pulled-%,%,$(pulled_stamps))
pushed := $(patsubst $(stamps_dir)/pushed-%,%,$(pushed_stamps))

#--------
# DEFINE
#--------
# TODO: We are only considering images without vendor. Local SI and oficial images.
# TODO: Separate official, base images (local or dockerhub) and target images.

define check-images-from
# Check the FROM clause for each dockerfile
#imagevendor
imagename_$1 = $(word 1, $(subst .., ,$1))
imagetag_$1  = $(word 2, $(subst .., ,$1))
image_$1 = $$(imagename_$1)..$$(imagetag_$1)

# path to Dockerfile
dockerfile_$1=$(lib_dir)/$$(imagename_$1)/$$(imagetag_$1)/Dockerfile

# FROM Docker Image
#fromvendor
fromname_$1 = $$(shell sed -n 's/.* \(.*\):.*/\1/p;q;' $$(dockerfile_$1))
fromtag_$1  = $$(shell sed -n 's/FROM *\(.*\)://p;q;' $$(dockerfile_$1))
from_$1     = $$(fromname_$1)..$$(fromtag_$1)

# Check whether a "FROM dependency" can be built from this library or not
ifneq (,$$(filter $$(from_$1),$(images)))
	# Base images found in this lib
	from_library+= $$(from_$1)
	from_library:=$$(sort $$(from_library)) # Sort also removes duplicates, which is the desired effect...
else
	# Not found in this lib, so pull them first.
	from_dockerhub+= $$(from_$1)
	from_dockerhub:=$$(sort $$(from_dockerhub))
endif

endef

#-------
# WRITE
#-------
$(foreach x,$(images),\
	$(eval $(call check-images-from,$(x)))\
)

## Write down the project file
setup:
	@echo images = $(images)
	@echo names = $(names)
	@echo dockerfiles = $(dockerfiles)
	@echo from_library = $(from_library)
	@echo from_dockerhub = $(from_dockerhub)
	@echo buildt = $(built)
	@echo pulled = $(pulled)
	@echo cleans = $(clean_targets)

