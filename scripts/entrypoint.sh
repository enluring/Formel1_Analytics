#!/bin/bash

# Variables
PG_DUMP_FILE="/docker-entrypoint-initdb.d/f1db_dump_latest.sql"
DB_NAME="f1db"
DB_USER="f1admin"
POSTGRES_PASSWORD="f1admin"
POSTGRES_HOST="f1_db"
POSTGRES_USER="f1admin"

# Wait for PostgreSQL container to be ready
until PGPASSWORD="$POSTGRES_PASSWORD" psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -c '\q' >/dev/null 2>&1; do
    echo "Waiting for PostgreSQL container to be ready..."
    sleep 1
done



# Create the database
psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -c "CREATE DATABASE $DB_NAME;"

# Restore the pgdump file
psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$DB_NAME" < "$PG_DUMP_FILE"
