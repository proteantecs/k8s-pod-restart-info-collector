# builder
FROM golang:1.23-alpine3.20 AS builder
WORKDIR /src
COPY go.* ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 go build -o /k8s-pod-restart-info-collector

# runner
FROM alpine:3.20
COPY --from=builder /k8s-pod-restart-info-collector /k8s-pod-restart-info-collector
CMD ["/k8s-pod-restart-info-collector"]
