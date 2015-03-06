require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches/{match_id}/players/{player_id}/guesses" do
  let(:json_response) { JSON.parse(last_response.body) }
  let(:response_data) { json_response.fetch("data") }

  describe "POST create" do
    context "correct guess" do
      it "responds with 'correct' outcome"
    end

    context "incorrect guess" do
      it "responds with 'incorrect' outcome"

      it "includes feedback"
    end
  end
end
