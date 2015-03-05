unless ENV["RACK_ENV"] == "production"
  require "dotenv"
  Dotenv.load
end

desc "Start a Blastermind console"
task :console do
  lib_path = File.expand_path('lib')
  $LOAD_PATH << lib_path
  require "pry"
  require "blastermind"
  Pry.start
end

namespace :db do
  require "sequel"
  Sequel.extension(:migration)
  Sequel.extension(:schema_dumper)
  db = Sequel.connect(ENV.fetch("DATABASE_URL"))

  task :migrate, [:version] do |_, args|
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

  task :reset do
    Sequel::Migrator.run(db, "db/migrations", target: 0)
    Sequel::Migrator.run(db, "db/migrations")
  end
end
