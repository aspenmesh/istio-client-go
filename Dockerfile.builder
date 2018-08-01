FROM golang:1.10-stretch as builder

WORKDIR /go/src/github.com/aspenmesh/istio-client-go

RUN curl -s -L \
    https://github.com/golang/dep/releases/download/v0.4.1/dep-linux-amd64 \
    > /go/bin/dep \
 && echo "31144e465e52ffbc0035248a10ddea61a09bf28b00784fd3fdd9882c8cbb2315 /go/bin/dep" | sha256sum -c - \
 && chmod +x /go/bin/dep

COPY . .

RUN make test
