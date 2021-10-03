FROM docker.io/golang:1.16-alpine AS build

WORKDIR /app

COPY go.mod /
COPY install.go ./

RUN go build -o /installer install.go

FROM docker.io/ubuntu:latest

WORKDIR /
COPY --from=build /installer /
