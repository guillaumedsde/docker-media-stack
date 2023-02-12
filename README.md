# [🐋 docker media stack](https://gitlab.com/guillaumedsde/docker-media-stack)

This is a docker-compose stack for multiple applications protected by **Authelia** Oauth with an **OpenLDAP** backend for authentication.
The **traefik** reverse proxy allows for automatic SSL certificate creation for all services with **letsencrypt**.
**Watchtower** handles docker image updates on a daily basis.

For a full list of applications, see the services defined in the `compose.yml` file.

## Configuration

Configuration is done by placing a `.env` file in the same directory as the `compose.yml` file.

## Credits

- Github user [brianspilner01](https://github.com/brianspilner01) for his awesome [subtitle cleanup script](https://raw.githubusercontent.com/brianspilner01/media-server-scripts/master/sub-clean.sh)