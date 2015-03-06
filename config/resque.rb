require "resque"
require "sequel/model"
Resque.redis = ENV.fetch("REDISTOGO_URL")
Resque.before_fork = Proc.new { Sequel::Model.db.disconnect }
Resque.after_fork = Proc.new { Sequel::Model.db.connect(ENV.fetch("DATABASE_URL")) }
