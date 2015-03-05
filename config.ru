lib_path = File.expand_path('lib')
$LOAD_PATH << lib_path

require 'blastermind/app'
run Blastermind::App
