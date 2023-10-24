FROM golang:1.21.3-alpine AS build

WORKDIR /src

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o main main.go

FROM scratch AS app

WORKDIR /app

COPY --from=build /src/main .

CMD [ "./main" ]