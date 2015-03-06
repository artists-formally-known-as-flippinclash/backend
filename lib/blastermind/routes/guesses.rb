require "json"
require "sequel"
require "sinatra"
require "sinatra/cross_origin"
require "blastermind/models/guess"
require "blastermind/models/match"
require "blastermind/representers/individual_guess"

module Blastermind
  module Routes
    class Guesses < Sinatra::Application
      register Sinatra::CrossOrigin

      configure do
        enable :cross_origin
      end

      post "/matches/:match_id/players/:player_id/guesses" do
      end
    end
  end
end
