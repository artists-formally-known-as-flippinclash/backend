require "sequel/model"
require "blastermind/models/code_peg"

module Blastermind
  module Models
    class Round < Sequel::Model
      SOLUTION_LENGTH = 4

      def self.generate(match)
        solution = CodePeg::STATES.sample(SOLUTION_LENGTH)
        new(solution: Sequel.pg_array(solution, :code_peg), match: match)
      end

      many_to_one :match

      # This is such a hack, it seems I don't know how to use Sequel's pg_array
      def solution
        solution_string = super
        solution_string[1..-2].split(",")
      end
    end
  end
end
