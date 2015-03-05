require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches" do
  let(:json_response) { JSON.parse(last_response.body) }

  describe "GET index" do
    it "responds with matches data" do
      id = Blastermind::Models::Match.insert(state: "match-making")
      match = Blastermind::Models::Match[id]

      get "/matches"

      expect(json_response.fetch("data").first.fetch("id")).to eq(match.id)
      expect(json_response.fetch("data").first.fetch("state")).to eq(match.state)
      expect(json_response.fetch("data").first.fetch("channel")).to eq(match.channel)
    end
  end
end
