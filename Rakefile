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
    require "dotenv"
    Dotenv.load
    version = ENV["VERSION"]
    version_option = "-M #{version}" if version
    `bin/sequel -m db/migrations #{version_option} $DATABASE_URL`
  end
end
