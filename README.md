# qbittorrent-port-forward-gluetun-server

A shell script and Docker container for automatically setting qBittorrent's listening port from Gluetun's control server.

## Config

### Environment Variables

| Variable     | Example                     | Default                 | Description                                                                    |
|--------------|-----------------------------|-------------------------|--------------------------------------------------------------------------------|
| QBT_USERNAME | `username`                  | `admin`                 | qBittorrent username                                                           |
| QBT_PASSWORD | `password`                  | `adminadmin`            | qBittorrent password                                                           |
| QBT_ADDR     | `http://192.168.1.100:8080` | `http://localhost:8080` | HTTP URL for the qBittorrent web UI, with port                                 |
| GTN_ADDR     | `http://192.168.1.100:8000` | `http://localhost:8000` | HTTP URL for the gluetun control server, with port                             |
| GTN_USERNAME | `username`                  | *None*                  | Username for authentication to gluetun control server (if basic auth enabled)  |
| GTN_PASSWORD | `password`                  | *None*                  | Password for authentication to gluetun control server (if basic auth enabled)  |
| GTN_APIKEY   | `apikey`                    | *None*                  | API Key for authentication to gluetun control server (if API key auth enabled) |
| CRON_INTERVAL| `*/5 * * * *`               | `*/10 * * * *`          | Cron schedule for how often to sync the port                                   |


## Gluetun Control Server Authentication
Starting in Gluetun v3.4, it is required to setup authentication on the Gluetun control server routes.

See this link for information on how to set this up: https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/control-server.md#authentication

Once configured in Gluetun, you can configure this container to use the appropriate authentication method:
- If using `none` auth, you do not need to provide any of the authentication environment variables
- If using `basic` auth, you should set the `GTN_USERNAME` and `GTN_PASSWORD` environment variables
- If using `apikey` auth, you should set the `GTN_APIKEY` environment variable

## Example

### Docker-Compose

The following is an example docker-compose:

```yaml
  qbittorrent-port-forward-gluetun-server:
    image: mjmeli/qbittorrent-port-forward-gluetun-server
    container_name: qbittorrent-port-forward-gluetun-server
    restart: unless-stopped
    environment:
      - QBT_USERNAME=username
      - QBT_PASSWORD=password
      - QBT_ADDR=http://192.168.1.100:8080
      - GTN_ADDR=http://192.168.1.100:8000
      - GTN_APIKEY=CHANGEME
```

## Development

### Build Image
```bash
docker build . -t qbittorrent-port-forward-gluetun-server
```

### Run Container
```bash
docker run --rm -it -e QBT_USERNAME=admin -e QBT_PASSWORD=adminadmin -e QBT_ADDR=http://192.168.1.100:8080 -e GTN_ADDR=http://192.168.1.100:8000 -e GTN_APIKEY=CHANGEME qbittorrent-port-forward-gluetun-server:latest
```
