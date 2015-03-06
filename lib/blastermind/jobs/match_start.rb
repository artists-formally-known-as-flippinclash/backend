require "blastermind/models/match"

module Blastermind
  module Jobs
    class MatchStart
      @queue = :matches

      def self.perform(match_id)
        match = Models::Match.first(id: match_id)
        match.start!
      end
    end
  end
end
