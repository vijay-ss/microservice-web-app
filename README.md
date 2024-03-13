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
- Makefile
- HTML