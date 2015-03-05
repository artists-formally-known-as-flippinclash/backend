require "json"
require "blastermind/db"
require "blastermind/models/match"
require "blastermind/representers/matches"

module Blastermind
  module Routes
    class Matches < Sinatra::Application
      get "/matches" do
        content_type :json
        matches = DB[:matches]
        matches
          .all
          .map { |match| Models::Match.new(match) }
          .extend(Representers::Matches)
          .to_json
      end
    end
  end
end
