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

all: generate-code test

# print-% is used to aid troubleshooting. Type `make print-XYZ` to print the value of XYZ.
print-%  : ; @echo $* = $($*)

generate-code:
	GO111MODULE=on ./scripts/generate-clientset.sh

clean-generated:
	rm -rf pkg/client
	rm -rf $(GENERATED_FILES)

clean:
	rm -rf _build

docker-build:
	docker build --target=builder -t $(BUILDER_TAG) \
		-f Dockerfile.builder .

test:
	GO111MODULE=on go build -v -o ${PWD}/_build/example-client ./cmd/example-client/...
	GO111MODULE=on go test ./pkg/apis/...

print-%:
	@echo '$*=$($*)'

.PHONY: all clean-generated print-% docker-build
