# docker media stack

This is a docker-compose stack for multiple applications protected by **Keycloak** Oauth with an **OpenLDAP** backend for authentication.
The **traefik** reverse proxy allows for automatic SSL certificate creation for all services with **letsencrypt**.
**Watchtower** handles docker image updates on a daily basis.

For a full list of applications, see the services defined in the `docker-compose.yml` file.

## Configuration

Configuration is done by placing a `.env` file in the same directory as the `docker-compose.yml` file.
A template for the configuration file is situated in `.env.sample` in this directory along with explanations for most variables.
