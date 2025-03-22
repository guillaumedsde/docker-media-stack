#!/bin/sh

set -o errexit
set -o nounset

mkdir -p /usr/local/etc/php/conf.d/

echo <<<EOF > /usr/local/etc/php/conf.d/redis-session.ini
session.save_handler = redis
session.save_path = "tcp://${HOOK_REDIS_HOST}:6379?auth=${HOOK_REDIS_HOST_PASSWORD}"
redis.session.locking_enabled = 1
redis.session.lock_retries = -1
redis.session.lock_wait_time = 10000
EOF
