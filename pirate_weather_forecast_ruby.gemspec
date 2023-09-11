# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require_relative "lib/pirate_weather_forecast_ruby/version"

Gem::Specification.new do |spec|
  spec.name        = "pirate_weather_forecast_ruby"
  spec.version     = ForecastIO::VERSION
  spec.authors     = ["Alex Cochran"]
  spec.email       = ["acochran50@gmail.com"]
  spec.homepage    = "https://github.com/alexcochran/pirate-weather-forecast-ruby"
  spec.summary     = "forecast.io API wrapper in Ruby"
  spec.description = "forecast.io API wrapper in Ruby"

  spec.required_ruby_version = ">= 3.2.2"

  spec.rubyforge_project = "pirate_weather_forecast_ruby"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("faraday")
  spec.add_dependency("hashie")
  spec.add_dependency("multi_json")

  spec.add_development_dependency("faraday-typhoeus")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")
  spec.add_development_dependency("vcr")
end
