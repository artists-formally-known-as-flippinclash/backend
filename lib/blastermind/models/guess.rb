module Blastermind
  module Models
    class Guess < Sequel::Model
      many_to_one :player
      many_to_one :round
    end
  end
end
