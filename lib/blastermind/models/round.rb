require "sequel/model"
require "blastermind/models/code_peg"
require "blastermind/representers/individual_round"

module Blastermind
  module Models
    class Round < Sequel::Model
      EVENTS = [
        ENDED = "round-ended".freeze,
      ].freeze

      def self.generate(match, solution = CodePeg.generate_solution)
        new(solution: Sequel.pg_array(solution, :code_peg), match: match)
      end

      MAX_GUESS_COUNT = 8

      one_to_many :guesses
      many_to_one :match

      def finished?
        finished
      end

      def finished!
        update(finished: true)
        trigger(ENDED)
      end

      def attempt(guess)
        finished! if guess.correct?
      end

      private

      def trigger(event)
        # It seems ROAR representers are single-use. I tried to extend the
        # original instance and reuse it hear, but to_json didn't behave
        # as expected after to_hash was called ಠ_ಠ
        pusher_data = extend(Representers::IndividualRound)
        Pusher[match.channel].trigger(event, pusher_data.to_hash)
      end
    end
  end
end
