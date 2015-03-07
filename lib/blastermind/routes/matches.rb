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
      MATCH_START_DELAY = ENV.fetch("MATCH_START_DELAY") { 30 }.to_i

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
          Resque.enqueue_in(MATCH_START_DELAY, Jobs::MatchStart, match.id)
        end

        player = Models::Player.create(name: player_params["name"], match: match)
        match.you = player
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
        content_type :json

        match_id = params.fetch("id")
        match = Models::Match[match_id]

        # THIS IS A HACK. WHY WON'T THE JOBS WORK ON HEROKU???
        begin
          match.start!
        rescue AASM::InvalidTransition
          return { errors: ["The match has already started!"] }.to_json
        end

        "{}"
      end
    end
  end
end
