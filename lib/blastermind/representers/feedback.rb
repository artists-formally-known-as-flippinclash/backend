require "roar/json"

module Blastermind
  module Representers
    module Feedback
      include Roar::JSON

      property :peg_count
      property :position_count
    end
  end
end
