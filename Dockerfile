FROM golang:1.22 as go

WORKDIR /app

# подготавливаем зависимости
COPY go.mod go.sum ./ 
RUN go mod download

#копируем программу и БД
COPY *.go tracker.db ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go test
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o parcel

# Запускаем
ENTRYPOINT ["/app/parcel"]
