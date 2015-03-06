require "sequel/model"
require "blastermind/models/code_peg"

module Blastermind
  module Models
    class Round < Sequel::Model
      # This is such a hack, it seems I don't know how to use Sequel's pg_array
      def solution
        solution_string = super
        solution_string[1..-2].split(",")
      end
    end
  end
end
