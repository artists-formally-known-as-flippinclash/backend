require "request_helper"
require "json"
require "blastermind/match_state_machine"
require "blastermind/models/match"

describe "/matches" do
  let(:json_response) { JSON.parse(last_response.body) }
  let(:response_data) { json_response.fetch("data") }

  describe "GET index" do
    it "responds with matches data" do
      match = Blastermind::Models::Match.create_to_play

      get "/matches"

      data = json_response.fetch("data")

      expect(data.first.fetch("id")).to eq(match.id)
      expect(data.first.fetch("state")).to eq(match.state)
      expect(data.first.fetch("channel")).to eq(match.channel)
    end
  end

  describe "POST create" do
    let(:player_name) { "J" }
    let(:player_params) { { player: { name: player_name } } }

    context "match seeking players exists" do
      it "responds with existing match" do
        match = Blastermind::Models::Match.create_to_play

        post "/matches", player_params

        expect(last_response.status).to eq(201) # created
        expect(response_data.fetch("id")).to eq(match.id)
        expect(response_data).to include("channel")
        expect(response_data.fetch("state")).to eq(Blastermind::MatchStateMachine::MATCH_MAKING)
      end
    end

    context "existing match is full" do
      it "creates a new match and responds with it" do
        match = Blastermind::Models::Match.create_to_play
        Blastermind::Models::Match::MAX_PLAYERS.times do |n|
          Blastermind::Models::Player.create(name: "player#{n}", match: match)
        end

        expect { post "/matches", player_params }.to change { Blastermind::Models::Match.count }.by(1)

        expect(last_response.status).to eq(201) # created
        expect(response_data).to include("id")
        expect(response_data).to include("channel")
        expect(response_data.fetch("state")).to eq(Blastermind::MatchStateMachine::MATCH_MAKING)
      end
    end

    context "no match exists that is seeking players" do
      it "creates a new match and responds with it" do
        expect { post "/matches", player_params }.to change { Blastermind::Models::Match.count }.by(1)

        expect(last_response.status).to eq(201) # created
        expect(response_data).to include("id")
        expect(response_data).to include("channel")
        expect(response_data.fetch("state")).to eq(Blastermind::MatchStateMachine::MATCH_MAKING)
      end
    end

    it "includes player in match" do
      post "/matches", player_params

      players = response_data.fetch("players")
      expect(players.first.fetch("name")).to eq("J")
    end
  end
end
