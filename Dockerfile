FROM golang:1.8-alpine

ENV OUTPUT bin/{{.Dir}}-{{.OS}}-{{.Arch}}
ENV OSARCH linux/386 linux/amd64 linux/arm darwin/amd64 windows/386 windows/amd64

RUN apk update && apk add git

ENV GOPATH /temp
RUN go get github.com/mitchellh/gox
RUN cp /temp/bin/gox /usr/local/go/bin

RUN adduser -u 1001 -S builder
USER builder

ENV GOPATH /data
WORKDIR /data
VOLUME /data

ENTRYPOINT gox -tags="netgo -a -v" -output=$OUTPUT -osarch="$OSARCH" -ldflags "$LDFLAGS" $PACKAGE
