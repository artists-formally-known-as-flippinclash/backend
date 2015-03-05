require "roar/json"

module Blastermind
  module Representers
    module Match
      include Roar::JSON

      property :id
      property :state
    end
  end
end
