# Parking

This is the best[citation needed] rails API for parking cars! ( bicycles, trucks and all other vehicles not currently supported ).

## Getting Started

Using docker you can get a copy of the project up and running for development and testing purposes in no time.
See deployment for notes on how to use the Dockerfile_prod locally.

### Prerequisites

* [docker](https://docs.docker.com/engine/install/)
* [docker-compose](https://docs.docker.com/compose/install/)

### Installing

Build image

```shell
docker-compose build
```

Run container

```shell
docker-compose up
```

To use application, send requests:

```shell
# parks car with plate 'AAB-0001'
curl --location --request POST 'http://localhost:3000/cars' \
--header 'Content-Type: application/json' \
--data-raw '{ "plate": "AAB-0001" }'

# returns useful routes
curl --location --request GET 'http://localhost:3000/'
```

Getting a shell into the container

```shell
docker exec -it parking_rails_1 bash
```

## Running the tests

With our development container running, type:

```shell
docker exec parking_rails_1 bundle exec rspec
```

## Deployment dockerfile

Follow this instructions to run a prod container on a local machine

Build image

```shell
docker build . -f Dockerfile_prod -t parking-prod
```

Run container for the first time

```shell
docker run -it --name parking_prod -p 3000:3000 parking-prod
```

Restarting container after first run

```shell
docker start -ia parking_prod
```

Getting a shell into the container

```shell
docker exec -it parking_prod bash
```
