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
  task :migrate do
    version = ENV["VERSION"]
    version_option = "-M #{version}" if version
    `bin/sequel -m db/migrations #{version_option} $DATABASE_URL`
  end
end

task :deploy do
  `git push heroku`
  puts "You should also migrate the db with `heroku run bin/rake db:migrate`"
end
