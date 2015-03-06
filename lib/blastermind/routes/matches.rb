require "json"
require "sinatra"
require "sinatra/cross_origin"
require "resque-scheduler"
require "blastermind/jobs/match_start"
require "blastermind/models/match"
require "blastermind/pusher"
require "blastermind/representers/individual_match"
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

        player_params = body.fetch("player") { Hash.new }

        match = Models::Match.find_or_create_to_play do |match|
          Resque.enqueue_in(30, Jobs::MatchStart, match.id)
        end

        Models::Player.create(name: player_params["name"], match: match)
        match.reload()

        if match.players.count == Models::Match::MAX_PLAYERS
          match.start!
        end

        content_type :json
        status 201
        match
          .extend(Representers::IndividualMatch)
          .to_json
      end

      post "/matches/:id/start" do
        match_id = params.fetch("id")
        match = Models::Match[match_id]

        # THIS IS A HACK. WHY WON'T THE JOBS WORK ON HEROKU???
        match.start!

        nil
      end
    end
  end
end
