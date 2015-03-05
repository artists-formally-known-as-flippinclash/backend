require 'rack/test'
require 'blastermind/app'
require 'spec_helper'

module Requests
  include Rack::Test::Methods

  def app
    Blastermind::App
  end
end

RSpec.configure do |c|
  c.include Requests
end
