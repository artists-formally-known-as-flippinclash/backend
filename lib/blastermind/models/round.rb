require "sequel/model"
require "blastermind/models/code_peg"

module Blastermind
  module Models
    class Round < Sequel::Model
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
      end

      def attempt(guess)
        finished! if guess.correct?
      end
    end
  end
end
