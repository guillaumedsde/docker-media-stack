#!/usr/bin/env bash

set -euo pipefail

install -D --mode=600 <(cat <<EOF
session.save_handler = redis
session.save_path = "tcp://${HOOK_REDIS_HOST}:6379?auth=${HOOK_REDIS_HOST_PASSWORD}"
redis.session.locking_enabled = 1
redis.session.lock_retries = -1
redis.session.lock_wait_time = 10000
EOF
) "/tmp/php_conf_d/redis-session.ini"
