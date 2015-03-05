require "roar/json"

module Blastermind
  module Representers
    module Match
      include Roar::JSON

      property :id
      property :state
      property :channel
    end
  end
end
