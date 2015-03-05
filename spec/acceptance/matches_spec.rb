require "request_helper"
require "json"
require "blastermind/db"

describe "/matches" do
  describe "index" do
    it "responds with matches data" do
      matches = Blastermind::DB[:matches]
      matches.insert(state: "match-making")

      get "/matches"

      json = JSON.parse(last_response.body)

      expect(json.fetch("data").first.fetch("state")).to eq("match-making")
    end
  end
end
