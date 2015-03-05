require "roar/json"

module Blastermind
  module Representers
    module Player
      include Roar::JSON

      property :id
      property :name
    end
  end
end
