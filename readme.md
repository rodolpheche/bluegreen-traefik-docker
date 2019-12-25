# Blue/Green deployment with Docker Swarm & Traefik

An implementation of zero downtime deployment pattern using Traefik priority

## Requirements

### Binaries

- docker
- curl

### Swarm

Init cluster and create network

```bash
docker swarm init
docker network create -d overlay front-network
```

## Getting started

### Prepare workspace

```bash
git clone https://github.com/rodolpheche/bluegreen-traefik-docker
cd bluegreen-traefik-docker
```

### Deploy Traefik

```bash
docker stack deploy -c stacks/docker-stack-http.yml http
```

> Access http://127.0.0.1:8080 to display Traefik UI

### Deploy Blue version

```bash
docker stack deploy -c stacks/docker-stack-appli-blue.yml appli-blue
```

> Access http://127.0.0.1 to display Blue version

### Launch script to check zero downtime

```bash
./bin/check-no-downtime.sh
```

### Deploy Green version

```bash
docker stack deploy -c stacks/docker-stack-appli-green.yml appli-green
```

### Switch from Blue to Green

```bash
docker service update --label-add "traefik.http.routers.colors-green.priority=100" appli-green_colors
docker service update --label-add "traefik.http.routers.colors-blue.priority=0" appli-blue_colors
```

> Access http://127.0.0.1 to display green version

### Clean up

```bash
docker stack rm http appli-green appli-blue
```
