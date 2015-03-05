module Blastermind
  module Models
    class Match < Sequel::Model
      def channel
        "match-#{id}"
      end
    end
  end
end
