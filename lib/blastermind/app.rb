require "sinatra"
require "blastermind/db"
require "blastermind/pusher"
require "blastermind/routes/guesses"
require "blastermind/routes/matches"

module Blastermind
  class App < Sinatra::Application
    use Rack::Deflater
    use Routes::Guesses
    use Routes::Matches

    get "/" do
      "Blastermind!"
    end
  end
end
