require "roar/json"
require "blastermind/representers/player"

module Blastermind
  module Representers
    module Round
      include Roar::JSON

      property :id
      property :solution
      property :winner, extend: Player
    end
  end
end
