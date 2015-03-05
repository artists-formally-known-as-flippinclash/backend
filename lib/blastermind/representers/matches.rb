require "roar/json"
require "blastermind/representers/match"

module Blastermind
  module Representers
    module Matches
      include Roar::JSON

      collection :data, extend: Match

      private

      def data
        self # currently we're extending arrays with this representer
      end
    end
  end
end
