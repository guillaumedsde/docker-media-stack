# [🐋 docker media stack](https://gitlab.com/guillaumedsde/docker-media-stack)

This is a docker-compose stack for multiple applications protected by **Authelia** Oauth with an **OpenLDAP** backend for authentication.
The **traefik** reverse proxy allows for automatic SSL certificate creation for all services with **letsencrypt**.

For a full list of applications, see the services defined in the `compose.yml` file.

## Configuration

Configuration is done by placing a `.env` file in the same directory as the `compose.yml` file.

## Docker daemon requirements

Some networks in `compose.yml` use statically pinned subnets in the
`172.16.243.0/24` - `172.16.254.0/24` range, and several applications
(miniflux, grafana, radarr, sonarr, prowlarr) reference those subnets in their
trusted network configuration.

To avoid subnet collisions, the docker daemon's `default-address-pools`
(configured in `/etc/docker/daemon.json`) must not allocate from the
`172.16.0.0/12` range, for example:

```json
{
  "default-address-pools": [
    {
      "base": "172.30.0.0/16",
      "size": 24
    }
  ]
}
```

## Credits

- Github user [brianspilner01](https://github.com/brianspilner01) for his awesome [subtitle cleanup script](https://raw.githubusercontent.com/brianspilner01/media-server-scripts/master/sub-clean.sh)
