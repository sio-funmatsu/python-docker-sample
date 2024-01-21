#!/bin/bash -eux

RYERUN="rye run"
MANAGE="$RYERUN python manage.py"

echo "unko unko"
echo $(pwd)  # == ./devcontainer/devcontainer.jsonで指定している場所（/workspaces/python-docker-sample）

rye sync --no-lock

cd "./python_src"
# $MANAGE makemessages -d djangojs -l en
# $MANAGE makemessages -l en
# $MANAGE compilemessages
# $MANAGE collectstatic --noinput
# $MANAGE makemigrations
$MANAGE migrate
# $MANAGE runserver 0.0.0.0:8000
# $RYERUN uvicorn config.asgi:application --host 0.0.0.0 --port 8000