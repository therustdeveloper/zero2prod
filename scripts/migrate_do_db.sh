#!/usr/bin/env bash
set -x
set -eo pipefail

cd ../

# Check if the PASSWORD parameter is provided
if [ -z "$1" ]; then
  echo "Error: Please provide the PASSWORD as a parameter."
  exit 1
fi

# Parameters
DB_PASSWORD="$1"

# Original DATABASE_URL
export DATABASE_URL=postgres://newsletter:$DB_PASSWORD@app-ed2c7f62-1496-4fec-b577-955446e32972-do-user-15018276-0.c.db.ondigitalocean.com:25060/newsletter?sslmode=require
sqlx migrate run