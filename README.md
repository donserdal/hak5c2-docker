# Hak5 C² in Docker

Latest Alpine image with the latest Hak5C2 software. 

## Deploy (docker Compose)

Below an example of a docker compose file

```yaml
version: '3'
services:
  Hak5C2:
    container_name: Hak5C2
    restart: unless-stopped
    ports:
      - '2022:2022'
      - '8080:8080'
    volumes:
      - 'hak5c2-data:/hak5/data'
    environment:
      - UID=1000
      - GID=1000
      - TZ=Europe/Amsterdam
      - c2hostname=c2.example.com
      - c2db=/hak5/data/c2.db
      - c2https=True
      - c2certFile=/hak5/letsencrypt.cer
      - c2keyFile=/hak5/letsencrypt.key
      - c2listenip=0.0.0.0 
      - c2listenport=8080
      - c2reverseProxy=True
      - c2reverseProxyPort=443
      - c2sshport=22
    image: donserdal/hak5c2
volumes:
  hak5c2-data:
```

## Deploy (docker)

Below an example of a docker command to run the image:

```sh
docker run --name hak5c2 -d -p 8080:8080/tcp -p 2022:2022 -v "$(pwd)"/data:/hak5/data -e 'c2hostname=c2.example.com' donserdal/hak5c2
```
