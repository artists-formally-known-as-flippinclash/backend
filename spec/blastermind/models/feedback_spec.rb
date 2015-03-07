require "spec_helper"
require "blastermind/models/feedback"

describe Blastermind::Models::Feedback do
  Round = Struct.new(:solution)
  Guess = Struct.new(:code_pegs)

  let(:round) { Round.new([1,2,3,4]) }

  describe "#peg_count" do
    it "excludes matches that are also in the right position" do
      guess = Guess.new([1,1,1,1])
      feedback = described_class.new(guess: guess, round: round)

      expect(feedback.peg_count).to eq(0)
    end

    it "includes matches not in the right position" do
      guess = Guess.new([5,1,5,5])
      feedback = described_class.new(guess: guess, round: round)

      expect(feedback.peg_count).to eq(1)
    end
  end

  describe "#position_count" do
    it "excludes matches that are not in the right position" do
      guess = Guess.new([5,1,1,1])
      feedback = described_class.new(guess: guess, round: round)

      expect(feedback.position_count).to eq(0)
    end

    it "includes matches that are in the right position" do
      guess = Guess.new([1,1,1,1])
      feedback = described_class.new(guess: guess, round: round)

      expect(feedback.position_count).to eq(1)
    end
  end
end
