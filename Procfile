web: bin/puma -C config/puma.rb
redis: redis-server
resque: QUEUE=* bin/rake resque:work
resque-scheduler: bin/rake resque:scheduler
resque-web: bin/resque-web --foreground --no-launch config/resque_web.rb
