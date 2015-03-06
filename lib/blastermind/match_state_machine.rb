require "statesman"
require "blastermind/models/match"
require "blastermind/pusher"
require "blastermind/representers/individual_match"

module Blastermind
  class MatchStateMachine
    STATES = [
      MATCH_MAKING = "match-making".freeze,
      IN_PROGRESS = "in-progress".freeze,
      FINISHED = "finished".freeze,
    ].freeze

    include Statesman::Machine

    state MATCH_MAKING, initial: true
    state IN_PROGRESS
    state FINISHED

    transition from: MATCH_MAKING, to: IN_PROGRESS

    after_transition(to: IN_PROGRESS) do |match|
      match.update(state: IN_PROGRESS)

      # It seems ROAR representers are single-use. I tried to extend the
      # original instance and reuse it hear, but to_json didn't behave
      # as expected after to_hash was called ಠ_ಠ
      pusher_data = match.extend(Representers::IndividualMatch)
      Pusher[match.channel]
        .trigger(Models::Match::MATCH_STARTED, pusher_data.to_hash)
    end
  end
end
