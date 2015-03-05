require "json"
require "blastermind/db"

module Blastermind
  module Routes
    class Matches < Sinatra::Application
      get "/matches" do
        content_type :json
        matches = DB[:matches]
        matches = matches.all
        %Q({"data": #{matches.to_json}})
      end
    end
  end
end
