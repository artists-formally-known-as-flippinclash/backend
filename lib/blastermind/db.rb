require "sequel"

module Blastermind
  DB = Sequel.connect(ENV["DATABASE_URL"])
  DB.extension(:pg_enum)
end
