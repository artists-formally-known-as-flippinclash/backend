require "sinatra"
require "sinatra/cross_origin"
require "blastermind/db"
require "blastermind/pusher"
require "blastermind/routes/matches"

module Blastermind
  class App < Sinatra::Application
    register Sinatra::CrossOrigin
    enable :cross_origin

    set :allow_origin, :any
    set :allow_methods, [:get, :post, :options]
    set :allow_credentials, true
    set :max_age, "1728000"
    set :expose_headers, ['Content-Type']

    use Rack::Deflater
    use Routes::Matches

    get "/" do
      "Blastermind!"
    end
  end
end
