require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches" do
  describe "index" do
    it "responds with matches data" do
      id = Blastermind::Models::Match.insert(state: "match-making")
      match = Blastermind::Models::Match[id]

      get "/matches"

      json = JSON.parse(last_response.body)

      expect(json.fetch("data").first.fetch("id")).to eq(match.id)
      expect(json.fetch("data").first.fetch("state")).to eq(match.state)
    end
  end
end
