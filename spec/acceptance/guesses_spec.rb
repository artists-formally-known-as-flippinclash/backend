require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches/{match_id}/players/{player_id}/guesses" do
  let(:json_response) { JSON.parse(last_response.body) }
  let(:response_data) { json_response.fetch("data") }

  describe "POST create" do
    context "correct guess" do
      let(:match) { Blastermind::Models::Match.create_to_play }
      let(:round) { match.current_round }
      let(:player) { Blastermind::Models::Player.create(name: "J", match: match) }

      it "responds with 'correct' outcome" do
        guess_params = {
          guess: { code_pegs: round.solution }
        }

        post "/matches/#{match.id}/players/#{player.id}/guesses", guess_params.to_json, "CONTENT_TYPE" => "application/json"

        expect(last_response.status).to be(201)
        expect(response_data.fetch("outcome")).to eq(Blastermind::Models::Guess::CORRECT.to_s)
      end
    end

    context "incorrect guess" do
      it "responds with 'incorrect' outcome"

      it "includes feedback"
    end
  end
end
