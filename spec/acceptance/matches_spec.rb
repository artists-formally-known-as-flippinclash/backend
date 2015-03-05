require "request_helper"
require "json"
require "blastermind/models/match"

describe "/matches" do
  let(:json_response) { JSON.parse(last_response.body) }

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
end
