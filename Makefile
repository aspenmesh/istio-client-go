PACKAGE := github.com/aspenmesh/istio-client-go

# pkg/apis is the location for CRD APIs.
# pkg/client is auto generated code
# zz_generated.deepcopy.go under pkg/apis/<group>/<version>/ is also generated
# code
DIRS := pkg/apis/networking pkg/apis/networking/v1alpha3
DEPS_ALL := $(foreach dir, $(DIRS), $(wildcard $(dir)/*.go))
GENERATED_FILES_PATTERN := %zz_generated.deepcopy.go
DEPS := $(filter-out $(GENERATED_FILES_PATTERN), $(DEPS_ALL))
GENERATED_FILES := $(filter $(GENERATED_FILES_PATTERN), $(DEPS_ALL))
BOILERPLATE := aspenmesh-boilerplate.go.txt

GROUP_VERSIONS := "networking:v1alpha3"

all: generate-code

generate-code:
	./vendor/k8s.io/code-generator/generate-groups.sh all \
		$(PACKAGE)/pkg/client \
		$(PACKAGE)/pkg/apis \
		$(GROUP_VERSIONS) \
		--go-header-file $(BOILERPLATE)

# Verify and/or install dev depenedencies
#
dev-setup: Gopkg.toml Gopkg.lock
	dep ensure --vendor-only

clean:
	rm -rf pkg/client
	rm -rf $(GENERATED_FILES)

print-%:
	@echo '$*=$($*)'

.PHONY: all clean dev-setup print-%
