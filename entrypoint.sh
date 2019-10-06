#!/bin/bash
set -e

if [[ -z "$KUBERNETES_SERVICE_HOST" ]]; then
  command="/bin/bash"
  if [[ -n "$*" ]]; then
    command="$*"
  fi
  exec /bin/bash -c "${command}"
fi


max_idle_mins="${MAX_IDLE_MINS:-180}"
echo "Max idle time: ${max_idle_mins} minutes"
touch /tmp
while (find /tmp -maxdepth 0 -mmin -${max_idle_mins} | grep -q '^' ); do
  sleep 60
  echo "Still active..."
done
echo "Toolbox idle for ${max_idle_mins} mins. Shutting down..."
curl -X POST http://127.0.0.1:15020/quitquitquit
