require "request_helper"

describe "/matches" do
  describe "index" do
    it "responds with matches data" do
      get "/matches"

      expect(last_response.body).to eq("{}")
    end
  end
end
