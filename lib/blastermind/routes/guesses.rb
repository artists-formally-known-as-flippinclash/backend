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
        content_type :json

        body = JSON.parse(request.body.read)
        guess_body = body.fetch("guess")
        code_pegs = guess_body.fetch("code_pegs")
        match_id = params.fetch("match_id")
        player_id = params.fetch("player_id")

        match = Models::Match[match_id]
        player = Models::Player[player_id]
        round = match.current_round

        if [player, match, round].any?(&:nil?)
          status 404
          return { errors: ["This resource does not exist."] }.to_json
        end

        if player.match != match
          status 403
          return { errors: ["You're not part of this match!"] }.to_json
        end

        unless match.in_progress?
          status 410
          return { errors: ["The match is not in progress!"] }.to_json
        end

        guess = Models::Guess.create(
          code_pegs: Sequel.pg_array(code_pegs, :code_pegs),
          player_id: player_id,
          round: round,
        )

        round.attempt(guess)

        if match.rounds.all?(&:finished?)
          match.finish!
        end

        status 201
        guess
          .extend(Representers::IndividualGuess)
          .to_json
      end
    end
  end
end
