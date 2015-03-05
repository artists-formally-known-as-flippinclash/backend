require "sinatra"
require "blastermind/db"
require "blastermind/pusher"
require "blastermind/routes/matches"

module Blastermind
  class App < Sinatra::Application
    use Rack::Deflater
    use Routes::Matches

    get "/" do
      "Blastermind!"
    end
  end
end
