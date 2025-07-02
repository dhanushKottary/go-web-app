FROM golang:1.24.4-alpine AS base

WORKDIR /app

COPY go.mod .
RUN go mod download
COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 9001

CMD ["./main"]