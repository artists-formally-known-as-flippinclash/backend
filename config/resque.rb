require "resque"
Resque.redis = ENV.fetch("REDISTOGO_URL")
