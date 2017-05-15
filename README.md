# Alfalfa

This is a Haystack implementation backed by a virtual building. Virtual building simulation is performed using OpenStudio and EnergyPlus.

## Getting Started

1. Install [Docker](https://www.docker.com) for your platform.
1. From a command prompt ```docker-compose up```.
1. Navigate to http://localhost:3000/nav to verify that the Haystack implementation is running.
1. Use ```Ctrl-C``` to stop the services.

## Making changes

1. Make source code changes as needed.
1. Verify that the Docker services are stopped with ```docker-compose down```.
1. Recreate the containers and restart services with ```docker-compose up```.

This is a basic workflow that is sure to work, other docker and docker-compose commands can be used to start / stop services without rebuilding. 

## Project Organization 

Development of this project is setup to happen in a handful of docker containers. This makes it easy to do ```docker-compose up```, and get a fully working development environment.  There are currently separate containers for web (The Haystack API server), worker (The thing that runs the simulation, aka master algorithm), database (mongo, the thing that holds a model's point dictionary and current / historical values), and queue (The thing where API requests go when they need to trigger something in the master algorithm). In this project there is one top level directory for each docker container.

