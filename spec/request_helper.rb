require "spec_helper"
require "rack/test"
require "database_cleaner"
require "blastermind"
require "fakeredis"
require "pusher-fake"
require "pusher-fake/support/rspec"

module Requests
  include Rack::Test::Methods

  def app
    Blastermind::App
  end
end

RSpec.configure do |c|
  c.include Requests

  c.before :suite do
    DatabaseCleaner[:sequel].strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  c.before :each do
    DatabaseCleaner[:sequel].start
  end

  c.after :each do
    DatabaseCleaner[:sequel].clean
  end
end
