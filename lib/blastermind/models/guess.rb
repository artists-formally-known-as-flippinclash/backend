module Blastermind
  module Models
    class Guess < Sequel::Model
      OUTCOMES = [
        CORRECT = :correct,
        INCORRECT = :incorrect,
      ].freeze

      many_to_one :player
      many_to_one :round

      def outcome
        correct? ? CORRECT : INCORRECT
      end
    end
  end
end
