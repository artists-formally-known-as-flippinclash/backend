require "json"

module Blastermind
  module Routes
    class Matches < Sinatra::Application
      get "/matches" do
        content_type :json
        matches = DB[:matches]
        matches = matches.all
        %Q({"matches": #{matches.to_json}})
      end
    end
  end
end
