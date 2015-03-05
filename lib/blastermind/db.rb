require "sequel"

module Blastermind
  DB = Sequel.connect(ENV["DATABASE_URL"])
end
