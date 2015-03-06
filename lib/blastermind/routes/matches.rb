require "json"
require "sinatra"
require "sinatra/cross_origin"
require "resque-scheduler"
require "blastermind/jobs"
require "blastermind/jobs/match_start"
require "blastermind/models/match"
require "blastermind/pusher"
require "blastermind/representers/matches"

module Blastermind
  module Routes
    class Matches < Sinatra::Application
      register Sinatra::CrossOrigin

      configure do
        enable :cross_origin
      end

      get "/matches" do
        Models::Match
          .all
          .extend(Representers::Matches)
          .to_json
      end

      post "/matches" do
        body = begin
                JSON.parse(request.body.read)
               rescue JSON::ParserError
                 params
               end

        player_params = body.fetch(:player) { Hash.new }

        match = Models::Match.find_or_create_to_play
        Models::Player.create(name: player_params[:name], match: match)

        Resque.enqueue_in(30, MatchStart, match.id)

        content_type :json
        status 201
        match
          .extend(Representers::IndividualMatch)
          .to_json
      end
    end
  end
end
