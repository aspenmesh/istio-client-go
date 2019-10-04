FROM golang:1.12-stretch as builder

WORKDIR /go/src/github.com/aspenmesh/istio-client-go

COPY . .

RUN make test
