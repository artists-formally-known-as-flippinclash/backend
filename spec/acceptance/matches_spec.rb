require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches" do
  let(:json_response) { JSON.parse(last_response.body) }
  let(:response_data) { json_response.fetch("data") }

  describe "GET index" do
    it "responds with matches data" do
      state = Blastermind::Models::Match::IN_PROGRESS
      id = Blastermind::Models::Match.insert(state: state)
      match = Blastermind::Models::Match[id]

      get "/matches"

      data = json_response.fetch("data")

      expect(data.first.fetch("id")).to eq(match.id)
      expect(data.first.fetch("state")).to eq(match.state)
      expect(data.first.fetch("channel")).to eq(match.channel)
    end
  end

  describe "POST create" do

    context "no match exists that is seeking players" do
      it "creates a new match and responds with it" do
        expect { post "/matches" }.to change { Blastermind::Models::Match.count }.by(1)

        expect(last_response.status).to eq(201) # created
        expect(response_data).to include("id")
        expect(response_data).to include("channel")
        expect(response_data.fetch("state")).to eq(Blastermind::Models::Match::MATCH_MAKING)
      end
    end
  end
end
