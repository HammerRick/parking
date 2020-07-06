# Run migrations
bundle exec rails db:migrate

# Clean a stale pid file
rm -f tmp/pids/server.pid

# Start the server
bundle exec rails server -b 0.0.0.0
