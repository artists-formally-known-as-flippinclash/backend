web: bin/thin start -p $PORT
redis: redis-server
resque: env TERM_CHILD=1 QUEUE=* bin/rake resque:work
resque_scheduler: env TERM_CHILD=1 bin/rake resque:scheduler
resque_web: bin/resque-web --foreground --no-launch config/resque_web.rb
