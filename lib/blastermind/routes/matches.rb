module Blastermind
  module Routes
    class Matches < Sinatra::Application
      get "/matches" do
        content_type :json
        "{}"
      end
    end
  end
end
