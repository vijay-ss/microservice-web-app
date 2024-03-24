FROM golang:1.21-alpine

RUN mkdir /build
WORKDIR /build

COPY go.* ./
RUN go mod download

COPY . ./

RUN cd /build/cmd/api && go build -o mailerApp

CMD ["./cmd/api/mailerApp"]