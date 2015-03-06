require "aasm"
require "sequel/model"

module Blastermind
  module Models
    class Match < Sequel::Model
      MAX_PLAYERS = 4

      EVENTS = [
        MATCH_STARTED = "match-started".freeze,
        MATCH_PROGRESS = "match-progress".freeze,
        MATCH_ENDED = "match-ended".freeze,
      ].freeze

      STATES = [
        MATCH_MAKING = :match_making,
        IN_PROGRESS = :in_progress,
        FINISHED = :finished,
      ].freeze

      def self.create_to_play(&on_create)
        on_create ||= lambda{|*|}
        create(state: MATCH_MAKING.to_s).tap(&on_create)
      end

      def self.find_or_create_to_play(&on_create)
        playable || create_to_play(&on_create)
      end

      def self.playable
        where(state: MATCH_MAKING.to_s).find do |match|
          match.players.count < MAX_PLAYERS
        end
      end

      include AASM

      aasm column: :state do
        state MATCH_MAKING
        state IN_PROGRESS
        state FINISHED

        event :start do
          transitions from: MATCH_MAKING, to: IN_PROGRESS

          after do
            # It seems ROAR representers are single-use. I tried to extend the
            # original instance and reuse it hear, but to_json didn't behave
            # as expected after to_hash was called ಠ_ಠ
            pusher_data = extend(Representers::IndividualMatch)
            Pusher[channel]
              .trigger(Models::Match::MATCH_STARTED, pusher_data.to_hash)
          end
        end
      end

      one_to_many :players

      def channel
        "match-#{id}"
      end
    end
  end
end
