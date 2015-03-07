require "roar/json"
require "blastermind/representers/player"

module Blastermind
  module Representers
    module Match
      include Roar::JSON

      property :id
      property :state
      property :channel
      property :name

      collection :players, extend: Player
    end
  end
end
