require "pry"
require "simplecov"
SimpleCov.start do
  add_filter "tests/"
  add_group "Models", "app/models"
  add_group "Routes", "app/routes"
  add_group "Representers", "app/representers"
end

ENV["RACK_ENV"] = "test"
require "minitest/autorun"
require "rack/test"
require File.expand_path "../../app", __FILE__

def app
  Hebankowy::App
end

include Rack::Test::Methods

module Helpers
  extend self

  def json_body
    @json_body ||= JSON.parse(last_response.body)
  end
end

include Helpers

Dragonfly.app.configure do
  datastore :memory
end
