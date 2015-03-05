module Blastermind
  module Models
    class Match < Sequel::Model
      STATES = [
        MATCH_MAKING = "match-making".freeze,
        IN_PROGRESS = "in-progress".freeze,
        FINISHED = "finished".freeze,
      ].freeze

      def self.create
        self.insert(state: MATCH_MAKING)
      end

      def channel
        "match-#{id}"
      end
    end
  end
end
