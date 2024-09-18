## This is a multistage Dockerfile to create container image for web-go application
# Stage 1 with base image
FROM golang:1.22.5 as base

WORKDIR /main

COPY go.md .

RUN go mod download

COPY . .

RUN go build -o main .

# Stage 2 with distroless image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
