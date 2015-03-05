require "roar/json"
require "blastermind/representers/match"

module Blastermind
  module Representers
    module IndividualMatch
      include Roar::JSON

      property :data, extend: Match

      private

      def data
        self
      end
    end
  end
end
