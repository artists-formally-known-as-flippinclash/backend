desc "Start a Blastermind console"
task :console do
  lib_path = File.expand_path('lib')
  $LOAD_PATH << lib_path
  require "pry"
  require "blastermind"
  Pry.start
end
