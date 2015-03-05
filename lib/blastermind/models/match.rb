require "virtus"

module Blastermind
  module Models
    class Match
      include Virtus.model

      attribute :id, Integer
      attribute :state, String

      def to_json
        %Q({"match":{"state":"#{state}"}})
      end
    end
  end
end
