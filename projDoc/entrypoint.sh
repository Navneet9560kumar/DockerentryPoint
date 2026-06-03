#!/bin/sh

set -e

echo "Container start ho raha hai"

# Step 1: PostgreSQL check
echo "PostgreSQL ka wait kar rahe hain..."
until pg_isready -h "$POSTGRES_HOST" -p "5432" -U "$POSTGRES_USER"; do
  echo "PostgreSQL ready nahi... 2 sec ruko"
  sleep 2
done
echo "PostgreSQL ready hai!"

# Step 2: Redis check
echo "Redis ka wait kar rahe hain..."
until redis-cli -h "$REDIS_HOST" -p "6379" ping | grep -q "PONG"; do
  echo "Redis ready nahi... 2 sec ruko"
  sleep 2
done
echo "Redis ready hai!"

# Step 3: Migrations
if [ "$RUN_MIGRATIONS" = "true" ]; then
  echo "Migrations run kar rahe hain..."
  alembic upgrade head
  echo "Migrations complete!"
fi

# Step 4: App start
echo "Application start kar rahe hain..."
exec "$@"