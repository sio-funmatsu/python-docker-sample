#-----------------------------------------------------------------------------#
# base image                                                                  #
#-----------------------------------------------------------------------------#
FROM python:3-slim AS base

# Warning抑制用
ENV DEBIAN_FRONTEND="noninteractive"
ENV DEBCONF_NOWARNINGS="yes"

# locale用
ARG LANG
ENV LANG=${LANG:-"en_US.UTF-8"}

# python用
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# localeの設定と必要なパッケージのインストール
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    locales \
    apt-utils \
    ca-certificates \
    curl \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/*

#-----------------------------------------------------------------------------#
# initialized rye image                                                       #
#-----------------------------------------------------------------------------#
FROM base AS rye-base

# bashに変更
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ryeのインストールオプション
ENV RYE_HOME="/opt/rye"
ENV PATH="$RYE_HOME/shims:$PATH"

# ryeのインストール
RUN curl -sSf https://rye-up.com/get | RYE_NO_AUTO_INSTALL=1 RYE_INSTALL_OPTION="--yes" bash

# 作業ディレクトリの設定
ARG APP_HOME
ENV APP_HOME=${APP_HOME:-"/app"}
WORKDIR $APP_HOME

ENV PYTHONPATH="$APP_HOME/src:$PYTHONPATH"

# ryeに必要なファイルのコピー、targetは最終行のディレクトリ($APP_HOME)
COPY .python-version \
     pyproject.toml \
     requirements.lock \
     requirements-dev.lock \
     README.md \
     $APP_HOME/

# COPYの代わりにこちらを実行するにはbuildxが必要
# RUN --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
#     --mount=type=bind,source=requirements.lock,target=requirements.lock \
#     --mount=type=bind,source=requirements-dev.lock,target=requirements-dev.lock \
#     --mount=type=bind,source=.python-version,target=.python-version \
#     --mount=type=bind,source=README.md,target=README.md \
#     rye sync --no-dev --no-lock

#-----------------------------------------------------------------------------#
# development image                                                           #
#-----------------------------------------------------------------------------#
FROM rye-base AS development

# ryeの補完を有効にする
RUN apt-get update \
 && apt-get install --no-install-recommends -y bash-completion \
 && apt-get clean -y \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p "$HOME/.local/share/bash-completion/completions" \
 && rye self completion > "$HOME/.local/share/bash-completion/completions/rye.bash" \
 && echo "source /etc/bash_completion" >> "$HOME/.bashrc"
