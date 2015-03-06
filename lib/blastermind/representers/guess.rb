require "roar/json"

module Blastermind
  module Representers
    module Guess
      include Roar::JSON

      property :id
      property :outcome
    end
  end
end
