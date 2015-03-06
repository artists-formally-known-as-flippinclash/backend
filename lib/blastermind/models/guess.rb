require "blastermind/models/feedback"

module Blastermind
  module Models
    class Guess < Sequel::Model
      OUTCOMES = [
        CORRECT = :correct,
        INCORRECT = :incorrect,
      ].freeze

      many_to_one :player
      many_to_one :round

      def correct?
        code_pegs == round.solution
      end

      def feedback
        @feedback ||= Feedback.new(guess: self, round: round)
      end

      def outcome
        correct? ? CORRECT : INCORRECT
      end
    end
  end
end
