# MCPL manuscript Docker environment

[![Docker Hub repository](https://img.shields.io/badge/Docker%20Hub-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/repository/docker/jeesoo9595/mcpl-paper)
[![Image size](https://img.shields.io/docker/image-size/jeesoo9595/mcpl-paper
)](https://hub.docker.com/repository/docker/jeesoo9595/mcpl-paper)
[![GitHub repository](https://img.shields.io/badge/github-repo-blue?logo=github)](https://github.com/JSS95/docker-mcpl-paper)

Docker image containing common packages for MCPL manuscripts.

Based on [jeesoo9595/latex-matplotlib](https://hub.docker.com/repository/docker/jeesoo9595/latex-matplotlib) with `inkscape` dependency.

## Tag rule

Images are tagged by the following rule:

```
[Python version]_[TeXLive version]
```

For example, `3.13_2025` contains Python 3.13 and TeXLive 2025.

### Supported versions

| Dependency | Version |
|---|---|
| Python | `3.13`, `3.14` |
| TeXLive | `2025` |

## Supported platforms

Each image is built for the following platforms:

| Platform | Host examples |
|---|---|
| `linux/amd64` | Linux (x86_64), Windows (Docker Desktop / WSL2), Intel Mac |
| `linux/arm64` | Apple Silicon Mac (Docker Desktop), AWS Graviton, Azure Arm VMs |

Docker automatically pulls the correct image for your architecture.

## Build arguments

The Dockerfile accepts the following build arguments:

| Argument | Default | Description |
|---|---|---|
| `PYTHON_VERSION` | `latest` | Python image tag (e.g., `3.13`, `3.14`) |
| `TEXLIVE_VERSION` | `latest` | TeXLive release year (e.g., `2024`, `2025`) |

Build example:

```bash
# Python 3.13, TeXLive 2025
docker build \
    --build-arg PYTHON_VERSION=3.13 \
    --build-arg TEXLIVE_VERSION=2025
    .
```
