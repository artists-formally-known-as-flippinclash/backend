require "sequel/model"

module Blastermind
  module Models
    class Player < Sequel::Model
      one_to_many :guesses
      many_to_one :match
    end
  end
end
