FROM debian:trixie-slim

ENV LANG="en_US.UTF-8"

ENV APP_HOME="/app"

ENV PYTHON_VERSION="3.12"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ENV RYE_VERSION="0.18.0"
ENV RYE_HOME="/opt/rye"
ENV PATH="$RYE_HOME/shims:$PATH"
ENV RYE_INSTALL_OPTION="--yes"

WORKDIR $APP_HOME

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y ca-certificates curl locales apt-utils && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    sed -i -E "s/# ($LANG)/\1/" /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=$LANG && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ENV RYEFILE="rye-x86_64-linux"
# RUN curl -sSL https://github.com/mitsuhiko/rye/releases/download/$RYE_VERSION/$RYEFILE.gz -o $RYEFILE.gz && \
#     gunzip $RYEFILE.gz && \
#     chmod +x $RYEFILE && \
#     ./$RYEFILE self install --yes && \
#     rm -rf $RYEFILE

RUN curl -sSf https://rye-up.com/get | RYE_VERSION=$RYE_VERSION bash

RUN echo "$PYTHON_VERSION" > .python-version
# COPY ./.python-version $APP_HOME/.python-version
COPY ./pyproject.toml "$APP_HOME/pyproject.toml"
COPY ./requirements.lock "$APP_HOME/requirements.lock"
COPY ./requirements-dev.lock "$APP_HOME/requirements-dev.lock"
COPY ./README.md README.md

RUN source "$RYE_HOME/env" && \
    # rye config --set-bool behavior.global-python=true && \
    rye sync --no-dev --no-lock && \
    mkdir -p "$HOME/.local/share/bash-completion/completions" && \
    rye self completion > "$HOME/.local/share/bash-completion/completions/rye.bash" && \
    echo "source $RYE_HOME/env" >> "$HOME/.bashrc"