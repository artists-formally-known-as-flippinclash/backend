require "request_helper"

describe "App root" do
  describe "GET /" do
    it "responds" do
      get "/"

      expect(last_response.body).to eq("Blastermind!")
    end
  end
end
