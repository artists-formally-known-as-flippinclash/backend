require "sinatra"

module Blastermind
  class App < Sinatra::Application
    use Rack::Deflater

    get "/" do
      "Blastermind!"
    end
  end
end
