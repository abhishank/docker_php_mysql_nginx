#!/bin/bash

# DOCKER_UID=`stat -c "%u" /home/projects/`
# DOCKER_GID=`stat -c "%g" /home/projects/`

# INCUMBENT_USER=`getent passwd $DOCKER_UID | cut -d: -f1`
# INCUMBENT_GROUP=`getent group $DOCKER_GID | cut -d: -f1`

# echo "Docker: uid = $DOCKER_UID, gid = $DOCKER_GID"
# echo "Incumbent: user = $INCUMBENT_USER, group = $INCUMBENT_GROUP"

# [ ! -z "${INCUMBENT_USER}" ] && usermod -u 99$DOCKER_UID $INCUMBENT_USER
#     usermod -u $DOCKER_UID www-data

# [ ! -z "${INCUMBENT_GROUP}" ] && groupmod -g 99$DOCKER_GID $INCUMBENT_GROUP
# groupmod -g $DOCKER_GID www-data

# chown -Rf $DOCKER_UID:$DOCKER_GID /app

# chmod -R 777 /app


# /usr/sbin/php-fpm -D 
tail -f /dev/null