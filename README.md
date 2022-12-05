# Github Actions Runner

## Requirements

1. [Docker Compose](https://docs.docker.com/compose/gettingstarted/)
2. [Github Runner](https://github.com/organizations/Apiki/settings/actions/runners)

## Importante

Sempre que rodar a CI gera um novo [token](https://github.com/organizations/Apiki/settings/actions/runners/new), geralmente o token terá esse formato `ATMR4IFESJE6ZGTG6SGFB7DDRYOKG`, e deve ser inserido um token diferente em cada docker-compose.yaml presente nas pastas gh-runner-1 e gh-runner-2, o token deve ser inserido na variável `RUNNER_TOKEN`.

## Start Runners

- Execute o comando abaixo nos diretórios gh-runner-1 e gh-runner-2

```bash
docker compose up -d
```

## Down Runners

- Execute o comando abaixo nos diretórios gh-runner-1 e gh-runner-2

```bash
docker compose down
```
