require "sequel/model"

module Blastermind
  module Models
    class Player < Sequel::Model
      many_to_one :match
    end
  end
end
