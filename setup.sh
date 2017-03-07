#!/bin/sh

echo "Waiting for PostgreSQL to start on 5444..."

while ! nc -z 10.11.156.20 5444; do
  sleep 0.1
done

echo "PostgreSQL started"

echo "Running database migrations...."
RAILS_ENV=stage bin/rails db:migrate

echo "Running database seed data...."
RAILS_ENV=stage bin/rails db:seed
