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
- Docker Swarm
- PostgresQL
- MongoDB
- RabbitMQ
- Makefile
- HTML
- Mailhog
- gRPC
- Kubernetes

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

## Deploying to Docker Swarm
`cd` into each service directory, then build and push to docker hub.

- `docker build -f logger-service.dockerfile -t <docker_account>/logger-service:1.0.0 .`
- `docker push <docker_account>/logger-service:1.0.0`

- `docker build -f broker-service.dockerfile -t <docker_account>/broker-service:1.0.0 .`
- `docker push <docker_account>/broker-service:1.0.0`

- `docker build -f authentication-service.dockerfile -t <docker_account>/authentication-service:1.0.0 .`
- `docker push <docker_account>/authentication-service:1.0.0`

- `docker build -f mail-service.dockerfile -t <docker_account>/mail-service:1.0.0 .`
- `docker push <docker_account>/mail-service:1.0.0`

- `docker build -f listener-service.dockerfile -t <docker_account>/listener-service:1.0.0 .`
- `docker push <docker_account>/listener-service:1.0.0`

- `docker build -f front-end.dockerfile -t <docker_account>/front-end:1.0.0 .`
- `docker push <docker_account>/front-end:1.0.0`

- `docker build -f caddy.dockerfile -t <docker_account>/micro-caddy:1.0.0 .`
- `docker push <docker_account>/micro-caddy:1.0.0`

Deploy to Docker Swarm: `docker stack deploy -c swarm.yml myapp`
view services: `docker service ls`
Scaling services example: `docker service scale myapp_listener-service=3`

`docker swarm init`
`docker stack deploy -c swarm.yml myapp`

## Deploying to Kubernetes

Start Minikube:
`minikube start --nodes=2`

Running a dockerized Postgres instance:
- `docker-compose -f postgres.yml up -d`

There are a few ways to expose the cluster to the local network:

Exposing the broker-service as a Load Balancer
- `kubectl expose deployment broker-service --type=LoadBalancer --port=8080 --target-port=8080`
- `minikube tunnel`

Ingress to cluster using Nginx
- `minikube addons enable ingress`
