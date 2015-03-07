require "roar/json"
require "blastermind/representers/feedback"

module Blastermind
  module Representers
    module Guess
      include Roar::JSON

      property :id
      property :outcome
      property :code_pegs
      property :feedback, extend: Feedback
    end
  end
end
