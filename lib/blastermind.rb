unless ENV["RACK_ENV"] == "production"
  require "dotenv"
  Dotenv.load
  require "pry"
end

require "blastermind/app"
