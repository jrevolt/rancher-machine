#syntax=docker/dockerfile

FROM golang:1.24 AS build
RUN --mount=dst=/context \
    --mount=type=cache,dst=/go \
    cd /context && go build -o /rancher-machine ./cmd/rancher-machine

FROM rancher/machine:v0.15.0-rancher125 AS runtime
COPY --from=build /rancher-machine /usr/local/bin/
