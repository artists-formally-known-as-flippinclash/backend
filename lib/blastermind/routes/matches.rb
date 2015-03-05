require "json"
require "blastermind/models/match"
require "blastermind/representers/individual_match"
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

      post "/matches" do
        content_type :json

        id = Models::Match.create
        match = Models::Match[id]

        status 201
        match
          .extend(Representers::IndividualMatch)
          .to_json
      end
    end
  end
end
