module Blastermind
  module Models
    class Feedback
      def initialize(guess: guess, round: round)
        @guess = guess
        @round = round
      end

      def peg_count
        missing_count = (round.solution - guess.code_pegs).count
        round.solution.count - missing_count - position_count
      end

      def position_count
        guess.code_pegs
          .zip(round.solution)
          .select { |(a,b)| a == b }
          .count
      end

      private

      attr_reader :guess, :round
    end
  end
end
