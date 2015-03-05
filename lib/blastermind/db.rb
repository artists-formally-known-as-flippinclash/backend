require "sequel"

module Blastermind
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.extension(:pg_enum)
end
