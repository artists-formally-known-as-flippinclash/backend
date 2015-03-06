require "blastermind/models/match"
require "blastermind/pusher"
require "blastermind/representers/individual_match"

module Blastermind
  module Jobs
    class MatchStart
      @queue = :matches

      def self.perform(match_id)
        match = Models::Match.first(id: match_id)

        # It seems ROAR representers are single-use. I tried to extend the
        # original instance and reuse it hear, but to_json didn't behave
        # as expected after to_hash was called ಠ_ಠ
        pusher_data = match.extend(Representers::IndividualMatch)
        Pusher[match.channel]
          .trigger(Models::Match::MATCH_STARTED, pusher_data.to_hash)
      end
    end
  end
end
