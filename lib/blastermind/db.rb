require "sequel"

module Blastermind
  Sequel.extension(:pg_array_ops)
  DB = Sequel.connect(ENV.fetch("DATABASE_URL"))
  DB.extension(:pg_array)
  DB.extension(:pg_enum)
end
