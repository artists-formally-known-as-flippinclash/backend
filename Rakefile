unless ENV["RACK_ENV"] == "production"
  require "dotenv"
  Dotenv.load
end

desc "Start a Blastermind console"
task console: :environment do
  require "pry"
  Pry.start
end

namespace :db do
  require "sequel"
  Sequel.extension(:migration)
  db = Sequel.connect(ENV.fetch("DATABASE_URL"))

  task :migrate, [:version] do |_, args|
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end

    Rake::Task["db:schema:dump"].invoke
  end

  task :reset do
    Sequel::Migrator.run(db, "db/migrations", target: 0)
    Sequel::Migrator.run(db, "db/migrations")
  end

  namespace :schema do
    task :dump do
      db.extension(:schema_dumper)
      schema = db.dump_schema_migration
      File.open("db/schema.rb", "w") { |f| f.write(schema) }
    end
  end
end

task :environment do
  lib_path = File.expand_path('lib')
  $LOAD_PATH << lib_path
  require "blastermind"
end

require "resque/tasks"
require 'resque/scheduler/tasks'

namespace :resque do
  task setup: :environment
end
