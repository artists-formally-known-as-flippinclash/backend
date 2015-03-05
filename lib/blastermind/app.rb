require "sinatra"
require "sinatra/cross_origin"
require "blastermind/db"
require "blastermind/pusher"
require "blastermind/routes/matches"

module Blastermind
  class App < Sinatra::Application
    register Sinatra::CrossOrigin
    enable :cross_origin

    use Rack::Deflater
    use Routes::Matches

    get "/" do
      "Blastermind!"
    end
  end
end
