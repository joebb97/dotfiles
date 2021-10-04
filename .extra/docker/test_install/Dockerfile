FROM docker.io/golang:1.16-alpine AS build

WORKDIR /app

COPY go.mod /
COPY install.go ./

RUN CGO_ENABLED=0 go build -a -o installer install.go

FROM docker.io/ubuntu:latest

WORKDIR /
COPY --from=build /app/installer .
