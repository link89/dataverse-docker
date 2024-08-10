#!/bin/bash
set -e

# clear proxy settings
export https_proxy=
export HTTPS_PROXY=
export HTTP_PROXY=
export http_proxy=
export all_proxy=
export ALL_PROXY=

# set locale
export LANG=en_US.UTF-8

# wait for postgres to be ready
while ! nc -z postgres 5432; do
  sleep 1
done
sleep 3  # wait more to be sure

# install dataverse if default.config exists and inited file does not exist
if [ ! -f /dataverse-installed ]; then
  if [ ! /tmp/dvinstall/default.config ]; then
    echo "default.config not found in dvinstall directory!"
    echo "You must add default.config to dvinstall directory for automated installation"
    exit 1
  fi

  # make a rw copy to avoid permission issues
  cp -r /tmp/dvinstall /tmp/dvinstall-rw

  pushd /tmp/dvinstall-rw
  # install dataverse
  python3 install.py -y -f --hostname 127.0.0.1

  # Run setup-all.sh again to work around 404 error
  # FIXME: ensure install process is robust!
  sleep 10 && ./setup-all.sh || true  # ignore errors
  touch /dataverse-installed
  popd
else
  /usr/local/payara6/bin/asadmin start-domain domain1
fi

# if there is /tmp/update-config script, run it
if [ -f /tmp/update-config ]; then
  /tmp/update-config
  # restart payara to apply changes
  /usr/local/payara6/bin/asadmin restart-domain domain1
fi

# tail the log file to screen for debugging
tail -f /usr/local/payara6/glassfish/domains/domain1/logs/server.log &

# use ps and grep to check if domain1 is running
DV_PID=$(pgrep -f "java -cp /usr/local/payara6/glassfish/domains/domain1")
echo "The PID of dataverse is $DV_PID"

# stop domain1 on SIGTERM
trap "/usr/local/payara6/bin/asadmin stop-domain domain1" SIGTERM SIGINT SIGKILL SIGQUIT

# wait for domain1 to stop
while kill -0 $DV_PID 2> /dev/null; do
  sleep 10
done

echo "Dataverse stopped unexpectedly!"
exit 1
