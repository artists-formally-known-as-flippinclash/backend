require "roar/json"
require "blastermind/representers/round"

module Blastermind
  module Representers
    module IndividualRound
      include Roar::JSON

      property :data, extend: Round

      private

      def data
        self
      end
    end
  end
end
