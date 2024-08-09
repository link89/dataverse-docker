#! /bin/bash
set -e

# default password
if [ -z "$R_USER" ]; then
  R_USER=rserve
fi

if [ -z "$R_PASS" ]; then
  R_PASS=rserve
fi

echo "$R_USER $R_PASS" > /etc/Rserv.pwd

R CMD Rserve --quiet --vanilla --RS-conf /etc/Rserv.conf --RS-pidfile /tmp/rserve.pid

# stop Rserve on SIGTERM
trap "kill -TERM $(cat /tmp/rserve.pid)" SIGTERM SIGINT SIGKILL SIGQUIT

# FIXME: this is a hack to keep the container running
# a better solution is to find a way to run Rserve in the foreground
while kill -0 $(cat /tmp/rserve.pid) 2> /dev/null; do
  sleep 5
done