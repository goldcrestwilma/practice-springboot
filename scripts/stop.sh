#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

IDLE_PORT=$(find_idle_port)

echo "> Check Running Application pid on $IDLE_PORT "
IDLE_PID=$(lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> Not exist application"
else
  echo "> Kill -15 $IDLE_PID"
  kill -15 ${IDLE_PID}
  sleep 5
fi