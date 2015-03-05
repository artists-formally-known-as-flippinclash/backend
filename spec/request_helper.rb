require 'rack/test'
require "database_cleaner"
require 'blastermind'
require 'spec_helper'

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
  end

  c.before :each do
    DatabaseCleaner[:sequel].start
  end

  c.after :each do
    DatabaseCleaner[:sequel].clean
  end
end
