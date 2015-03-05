require "roar/json"
require "blastermind/representers/player"

module Blastermind
  module Representers
    module Match
      include Roar::JSON

      property :id
      property :state
      property :channel

      collection :players, extend: Player
    end
  end
end
