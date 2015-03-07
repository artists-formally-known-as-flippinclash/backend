require "roar/json"
require "blastermind/representers/guess"

module Blastermind
  module Representers
    module Player
      include Roar::JSON

      property :id
      property :name

      collection :guesses, extend: Guess
    end
  end
end
