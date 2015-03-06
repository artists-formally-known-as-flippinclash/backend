require "resque"

Resque.configure do |c|
  c.redis = ENV.fetch("REDISTOGO_URL")
end
