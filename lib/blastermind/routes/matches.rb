require "json"
require "blastermind/models/match"
require "blastermind/pusher"
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

        # It seems ROAR representers are single-use. I tried to extend the
        # original instance and reuse it hear, but to_json didn't behave
        # as expected after to_hash was called ಠ_ಠ
        pusher_data = match.extend(Representers::IndividualMatch)
        Pusher[match.channel]
          .trigger(Models::Match::MATCH_STARTED, pusher_data.to_hash)

        status 201
        match
          .extend(Representers::IndividualMatch)
          .to_json
      end
    end
  end
end
