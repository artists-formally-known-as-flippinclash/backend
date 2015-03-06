require "roar/json"
require "blastermind/representers/guess"

module Blastermind
  module Representers
    module IndividualGuess
      include Roar::JSON

      property :data, extend: Guess

      private

      def data
        self
      end
    end
  end
end
