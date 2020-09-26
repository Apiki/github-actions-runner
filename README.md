# github-actions-runner

## Requirements

1. Docker-compose

## Install

1. Copy ```.env``` file

```cp .env.example .env```

2. Up containers

```docker-compose up -d```

## Scaling

```docker-compose scale runner-node=2 runner-php=2```