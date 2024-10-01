FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN go build -ldflags="-s -w" -o fullcycle .

RUN apk add --no-cache upx && upx --best fullcycle

FROM scratch

COPY --from=builder /app/fullcycle /fullcycle

ENTRYPOINT ["/fullcycle"]
