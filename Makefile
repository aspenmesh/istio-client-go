PACKAGE := github.com/magneticio/istio-client-go
DEST_DIR := $(abspath .)

ifeq ($(BRANCH_NAME)$(BUILD_ID),)
  BUILDER_TAG := istio-client-go-builder
else
  BUILDER_TAG := localhost:5000/istio-client-go:${BRANCH_NAME}-${BUILD_ID}
endif

# pkg/apis is the location for CRD APIs.
# pkg/client is auto generated code
# zz_generated.deepcopy.go under pkg/apis/<group>/<version>/ is also generated
# code
DIRS := pkg/apis/networking pkg/apis/networking/v1alpha3 pkg/apis/authentication pkg/apis/authentication/v1alpha1
DEPS_ALL := $(foreach dir, $(DIRS), $(wildcard $(dir)/*.go))
GENERATED_FILES_PATTERN := %zz_generated.deepcopy.go
DEPS := $(filter-out $(GENERATED_FILES_PATTERN), $(DEPS_ALL))
GENERATED_FILES := $(filter $(GENERATED_FILES_PATTERN), $(DEPS_ALL))
BOILERPLATE := boilerplate.go.txt

GROUP_VERSIONS := "networking:v1alpha3, authentication:v1alpha1"

all: generate-code test

generate-code: dev-setup
	/bin/bash -x ./generate-groups.sh all \
		$(PACKAGE)/pkg/client \
		$(PACKAGE)/pkg/apis \
		$(GROUP_VERSIONS) \
		$(PACKAGE) \
		$(DEST_DIR) \
		--go-header-file $(BOILERPLATE)

# Verify and/or install dev depenedencies
#
dev-setup:
	go mod download


clean-generated:
	rm -rf pkg/client
	rm -rf $(GENERATED_FILES)

clean:
	rm -rf _build

docker-build:
	docker build --target=builder -t $(BUILDER_TAG) \
		-f Dockerfile.builder .

test: dev-setup
	# go build -v -o ${PWD}/_build/example-client ./cmd/example-client/...
	go test ./pkg/apis/...

print-%:
	@echo '$*=$($*)'

.PHONY: all clean-generated dev-setup print-% docker-build
