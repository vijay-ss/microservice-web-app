# Microservice Web Application

A front end web application that connects to 5 microservices:

- Broker - single point of entry to microservices
- Authentication - PostgreSQL database for handling user auth
- Logger - MongoDB
- Mail - sends an email with specified template
- Listener - consumes messages in RabbitMQ and initiates a process

A front end html template is used to interface between the microservices.

## Tools
- Go
- Docker
- PostgresQL
- MongoDB
- RabbitMQ
- Makefile
- HTML
- Mailhog
- gRPC

## Microservices in Depth

### Broker Service
Handles requests from the front end application. The Broker will process the request and send a response back to the front end application.

### Authentication Service
Allows the user to authenticate via the Broker Service. Data is persisted to a PostgresQL instance within Docker. This Authentication service can be used alongside any other microservice.

### Logger Service
Only available within the overall microservice Kubernetes cluster. It stores all information within a MongoDB database.

### Mail Service
A mail server which allows the Broker or Listener service to send email notifications.

### Listener Service
Retrieves events/requests from RabbitMQ for consumption by the other microservices.

## Logging connections with gRPC
In many cases, logging speed can be sped up using gRPC over JSON. The Logger service will contain a Listener for accepting gRPC connections made from the Broker via the Frond End.

The following command generates the appropriate grpc code from the `logs.proto` files:
- `protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative logs.proto`