require "json"
require "blastermind/models/match"
require "blastermind/representers/matches"

module Blastermind
  module Routes
    class Matches < Sinatra::Application
      get "/matches" do
        content_type :json

        Models::Match
          .all
          .extend(Representers::Matches)
          .to_json
      end
    end
  end
end
