require "roar/json"
require "blastermind/representers/match"
require "blastermind/representers/player"

module Blastermind
  module Representers
    module IndividualMatch
      include Roar::JSON

      property :data, extend: Match
      property :you, extend: Player

      private

      def data
        self
      end
    end
  end
end
