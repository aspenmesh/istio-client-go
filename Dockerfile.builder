FROM golang:1.12-stretch as builder
ARG GO111MODULE=on

WORKDIR /go/src/github.com/aspenmesh/istio-client-go

COPY . .

RUN make test
