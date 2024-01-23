#!/bin/bash -eux

RYERUN="rye run"
MANAGE="$RYERUN python manage.py"

# echo $(pwd)  # == docker-compose.ymlのwork_dirで指定した場所(/app)

rye sync --no-dev --no-lock

cd ./src
# $MANAGE makemessages -d djangojs -l en
# $MANAGE makemessages -l en
# $MANAGE compilemessages
# $MANAGE collectstatic --noinput
# $MANAGE makemigrations
# $MANAGE migrate

$RYERUN dev_server
# $RYERUN server
