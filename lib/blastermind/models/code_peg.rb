module Blastermind
  module Models
    class CodePeg
      STATES = [
        ALPHA = "alpha".freeze,
        BETA = "beta".freeze,
        GAMMA = "gamma".freeze,
        DELTA = "delta".freeze,
        EPSILON = "epsilon".freeze,
        ZETA = "zeta".freeze,
      ].freeze

      SOLUTION_LENGTH = 4

      def self.generate_solution
        STATES.sample(SOLUTION_LENGTH)
      end
    end
  end
end
