FROM debian:trixie-slim

ENV PYTHON_VERSION="cpython@3.12.0"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ENV RYE_VERSION="0.17.0"
ENV RYE_HOME="/opt/rye"
ENV PATH="$RYE_HOME/shims:$PATH"
ENV RYE_INSTALL_OPTION="--yes"

WORKDIR /app

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y ca-certificates curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV RYEFILE="rye-x86_64-linux"
# RUN curl -sSL https://github.com/mitsuhiko/rye/releases/download/$RYE_VERSION/$RYEFILE.gz -o $RYEFILE.gz && \
#     gunzip $RYEFILE.gz && \
#     chmod +x $RYEFILE && \
#     ./$RYEFILE self install --yes && \
#     rm -rf $RYEFILE

RUN curl -sSf https://rye-up.com/get | bash

RUN echo "$PYTHON_VERSION" > .python-version
COPY ./pyproject.toml pyproject.toml
COPY ./requirements.lock requirements.lock
COPY ./requirements-dev.lock requirements-dev.lock
COPY ./README.md README.md

RUN . $RYE_HOME/env && rye sync --no-dev --no-lock
RUN echo ". '$RYE_HOME/env'" >> "$HOME/.bashrc"
