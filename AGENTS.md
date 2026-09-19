# docker-media-stack

## Project structure

This repository contains a docker-compose file `compose.yml` to orchestrate my
self hosted services.
The project aims to keep as much configuration as possible (app configuration,
dependency order etc...) into that single compose file.

The `config/` directory contains configuration files for different software that
are bind mounted read-only into the different application containers, whenever
possible
The configuration files are templated to prevent secrets or personal information
(email addresses, domain names etc...) from being comitted into the repository.

Similarly, the compose file is templated using environment variables (loaded
from a `.env` files stored elsewhere at runtime).

Most services are exposed behind a Traefik reverse proxy preferably using Authelia
as the Traefik forward auth provider

## Coding instructions

- Use the IDE's tooling and avoid shell commands whenever possible.
- avoid code reuse using environment variables and YAML anchors whenever possible
- prefer long syntax whenever possible (port binds, volume/bind mounts etc...)
- prefer configuring applications using environment variables or CLI arguments
  when possible.
- Every service should have a healthcheck, carefully configure service dependency
  using `service_healthy`
- read-only root filesystem and mounts whenever possible
- Limit container resources (CPU, RAM, PID, I/O, capabilities etc...) as much as
  possible
- avoid running containers as root, prefer setting UID/GID using compose's `user:`
  parameter instead of docker image's UID/GID/PUID/PGID environment variables.
- Don't bind mount the docker socket, if you must, use a filtering proxy in front
  to limit docker API access.
- When networking containers together, use a dedicated network for each "link" between
  containers
