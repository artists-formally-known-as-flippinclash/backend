lib_path = File.expand_path('lib')
$LOAD_PATH << lib_path

require 'blastermind'
require_relative "./config/redis"
run Blastermind::App
