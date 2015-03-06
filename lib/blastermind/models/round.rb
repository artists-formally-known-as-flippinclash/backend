require "sequel/model"
require "blastermind/models/code_peg"

module Blastermind
  module Models
    class Round < Sequel::Model
      def self.generate(match, solution = CodePeg.generate_solution)
        new(solution: Sequel.pg_array(solution, :code_peg), match: match)
      end

      one_to_many :guesses
      many_to_one :match

      def finished?
        finished
      end
    end
  end
end
