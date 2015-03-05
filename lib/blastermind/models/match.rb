module Blastermind
  module Models
    class Match < Sequel::Model
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
        create(state: MATCH_MAKING)
      end

      def self.find_or_create_to_play
        first(state: MATCH_MAKING) || create_to_play
      end

      def channel
        "match-#{id}"
      end
    end
  end
end
