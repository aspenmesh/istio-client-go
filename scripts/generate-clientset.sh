#!/bin/bash

set -eEo pipefail

if [[ ! $GOPATH ]]; then
  echo >&2 "GOPATH not defined. Must be run in a Go environment."
  exit 1
fi

SRC_DIR=$GOPATH/src
CLIENT_DIR=$SRC_DIR/github.com/aspenmesh/istio-client-go

# Field should be 2 for a require dependency and 4 for a replace dependency
CODE_GEN_VER_FIELD=2
CODE_GEN_VER=$(grep k8s.io/code-generator $CLIENT_DIR/go.mod | head -1 | cut -f $CODE_GEN_VER_FIELD -d\ )

go get k8s.io/code-generator/cmd/client-gen@$CODE_GEN_VER

# If this fails, go get k8s.io/code-generator
CODE_GEN=$(go list -f '{{ .Dir }}' -m k8s.io/code-generator@$CODE_GEN_VER)

chmod +x $CODE_GEN/generate-groups.sh

$CODE_GEN/generate-groups.sh all \
  github.com/aspenmesh/istio-client-go/pkg/client github.com/aspenmesh/istio-client-go/pkg/apis \
  "networking:v1alpha3, authentication:v1alpha1" \
  --output-base $CLIENT_DIR/../../.. \
  --go-header-file $CLIENT_DIR/aspenmesh-boilerplate.go.txt
