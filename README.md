# MCPL manuscript Docker environment

Docker image containing common packages for MCPL manuscripts.

## Tag rule

Images are tagged by the following rule:

```
[Python version]_[LaTeX version]
```

For example, `3.13_2025` contains Python 3.13 and LaTex 2025.

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
