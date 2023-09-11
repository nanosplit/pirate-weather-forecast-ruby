# frozen_string_literal: true

require "rspec"
require "pirate_weather_forecast_ruby"

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

require "vcr"
require "faraday/typhoeus"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :typhoeus
  c.allow_http_connections_when_no_cassette = false
end

Faraday.default_adapter = :typhoeus

RSpec.configure do |config|
  config.before(:each) do
    ForecastIO.api_key = nil
  end
end
