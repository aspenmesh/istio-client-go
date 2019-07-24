module github.com/magneticio/istio-client-go

go 1.12

replace istio.io/api => github.com/rcernich/istio-api v0.0.0-20190211150719-23148abe2cc6

require (
	github.com/gogo/googleapis v1.2.0 // indirect
	github.com/gogo/protobuf v1.2.1
	github.com/golang/protobuf v1.2.0
	github.com/konsorten/go-windows-terminal-sequences v1.0.2 // indirect
	github.com/sirupsen/logrus v1.4.1
	github.com/stretchr/testify v1.3.0
	google.golang.org/grpc v1.22.0 // indirect
	gopkg.in/inf.v0 v0.9.1 // indirect
	istio.io/api v0.0.0-20190408162927-e9ab8d6a54a6
	k8s.io/apimachinery v0.0.0-20190719140911-bfcf53abc9f8
)
