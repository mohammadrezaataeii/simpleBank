#!/bin/bash
set -e
 echo  "run db migrate"
 /app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up
 echo "start the app"
 exec "$@"