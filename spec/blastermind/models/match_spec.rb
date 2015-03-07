require "request_helper"
require "blastermind/models/guess"
require "blastermind/models/player"

describe Blastermind::Models::Match do
  describe "#winner" do
    it "returns the player with the most match wins" do
      match = described_class.create_to_play
      player = Blastermind::Models::Player.create(name: "J", match: match)
      match.start!
      round = match.rounds.first
      Blastermind::Models::Guess.create(
        code_pegs: Sequel.pg_array(round.solution, :code_pegs),
        player_id: player.id,
        round: round,
      )

      expect(match.winner).to eq(player)
    end
  end
end
