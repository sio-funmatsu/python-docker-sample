#!/bin/bash -eux

RYERUN="rye run"
MANAGE="$RYERUN python manage.py"

# echo $(pwd) # == docker-compose.ymlのwork_dirで指定した場所(/app/python_src)

# rye sync --no-dev --no-lock

cd /app/python_src
# $MANAGE makemessages -d djangojs -l en
# $MANAGE makemessages -l en
# $MANAGE compilemessages
# $MANAGE collectstatic --noinput
# $MANAGE makemigrations
# $MANAGE migrate
$MANAGE runserver 0.0.0.0:8000
# $RYERUN uvicorn config.asgi:application --host 0.0.0.0 --port 8000