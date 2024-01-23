#!/bin/bash -eux

RYERUN="rye run"
MANAGE="$RYERUN python manage.py"

# echo $(pwd)  # == ./devcontainer/devcontainer.jsonで指定している場所（/workspaces/python-docker-sample）

rye sync --no-lock

cd ./src
# $MANAGE makemessages -d djangojs -l en
# $MANAGE makemessages -l en
# $MANAGE compilemessages
# $MANAGE collectstatic --noinput
# $MANAGE makemigrations
$MANAGE migrate

# $RYERUN dev_server
# $RYERUN server