module github.com/aspenmesh/istio-client-go

go 1.12

require (
	github.com/evanphx/json-patch v4.5.0+incompatible // indirect
	github.com/gogo/protobuf v1.3.0
	github.com/golang/groupcache v0.0.0-20191002201903-404acd9df4cc // indirect
	github.com/golang/protobuf v1.3.2
	github.com/googleapis/gnostic v0.3.1 // indirect
	github.com/hashicorp/golang-lru v0.5.3 // indirect
	github.com/imdario/mergo v0.3.7 // indirect
	github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect
	github.com/pkg/errors v0.8.1 // indirect
	github.com/sirupsen/logrus v1.4.2
	github.com/stretchr/testify v1.4.0
	golang.org/x/crypto v0.0.0-20190911031432-227b76d455e7 // indirect
	golang.org/x/net v0.0.0-20190912160710-24e19bdeb0f2 // indirect
	golang.org/x/sys v0.0.0-20190912141932-bc967efca4b8 // indirect
	golang.org/x/time v0.0.0-20190308202827-9d24e82272b4 // indirect
	google.golang.org/appengine v1.6.2 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	istio.io/api v0.0.0-20191115173247-e1a1952e5b81
	k8s.io/apimachinery v0.0.0-20190913080033-27d36303b655
	k8s.io/client-go v0.0.0-20190620085101-78d2af792bab
	k8s.io/code-generator v0.0.0-20190612205613-18da4a14b22b // indirect
)

replace (
	github.com/golang/protobuf => github.com/golang/protobuf v1.3.2
	k8s.io/api => k8s.io/api v0.0.0-20191003000013-35e20aa79eb8
	k8s.io/apimachinery => k8s.io/apimachinery v0.0.0-20190913080033-27d36303b655
	k8s.io/client-go => k8s.io/client-go v0.0.0-20190918200256-06eb1244587a
	k8s.io/code-generator => k8s.io/code-generator v0.0.0-20190927045949-f81bca4f5e85
)
