#!/bin/bash
set -e

rm -f /usr/src/app/tmp/pids/server.pid

rails db:create

exec "$@"