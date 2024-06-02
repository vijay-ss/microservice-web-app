FROM golang:1.21-alpine

RUN mkdir /build
WORKDIR /build

COPY go.* ./
RUN go mod download

COPY . ./

RUN cd /build/cmd/web && go build -o frontEndApp

CMD ["./cmd/web/frontEndApp"]