FROM golang:1.26-alpine AS builder

ENV CGO_ENABLED=0
WORKDIR /go/src/github.com/Macmod/sopa

ADD https://github.com/Macmod/sopa.git .
RUN go mod download
RUN go install -ldflags="-s -w" -trimpath ./cmd/...

FROM scratch

COPY --from=builder /go/bin/sopa /sopa
WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT [ "/sopa" ]
CMD ["--help"]
