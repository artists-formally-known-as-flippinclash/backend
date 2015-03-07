require "roar/json"
require "blastermind/representers/player"
require "blastermind/representers/round"

module Blastermind
  module Representers
    module Match
      include Roar::JSON

      property :id
      property :state
      property :channel
      property :name
      property :winner, extend: Player

      collection :players, extend: Player
      collection :rounds, extend: Round
    end
  end
end
