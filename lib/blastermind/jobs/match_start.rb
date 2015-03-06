require "blastermind/models/match"
require "blastermind/match_state_machine"

module Blastermind
  module Jobs
    class MatchStart
      @queue = :matches

      def self.perform(match_id)
        match = Models::Match.first(id: match_id)
        match.state_machine.transition_to(MatchStateMachine::IN_PROGRESS)
      end
    end
  end
end
