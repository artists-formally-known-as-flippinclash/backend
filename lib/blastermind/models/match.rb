require "sequel/model"

module Blastermind
  module Models
    class Match < Sequel::Model
      MAX_PLAYERS = 4

      EVENTS = [
        MATCH_STARTED = "match-started".freeze,
        MATCH_PROGRESS = "match-progress".freeze,
        MATCH_ENDED = "match-ended".freeze,
      ].freeze

      STATES = [
        MATCH_MAKING = "match-making".freeze,
        IN_PROGRESS = "in-progress".freeze,
        FINISHED = "finished".freeze,
      ].freeze

      def self.create_to_play
        create(state: MatchStateMachine::MATCH_MAKING)
      end

      def self.find_or_create_to_play
        playable || create_to_play
      end

      def self.playable
        where(state: MATCH_MAKING).find do |match|
          match.players.count < MAX_PLAYERS
        end
      end

      one_to_many :players

      def channel
        "match-#{id}"
      end
    end
  end
end
