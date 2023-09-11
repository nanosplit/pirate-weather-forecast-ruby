# frozen_string_literal: true

require "pirate_weather_forecast_ruby/configuration"
require "pirate_weather_forecast_ruby/version"

require "hashie"
require "multi_json"
require "faraday"

module ForecastIO
  extend Configuration

  self.default_params = {}

  class << self
    # Retrieve the forecast for a given latitude and longitude.
    #
    # @param latitude [String] Latitude.
    # @param longitude [String] Longitude.
    # @param options [String] Optional parameters. Valid options are `:time` and `:params`.
    def forecast(latitude, longitude, options = {})
      forecast_url = "#{ForecastIO.api_endpoint}/forecast/#{ForecastIO.api_key}/#{latitude},#{longitude}"
      forecast_url += ",#{options[:time]}" if options[:time]

      forecast_response = get(forecast_url, options[:params])

      return unless forecast_response.success?

      Hashie::Mash.new(MultiJson.load(forecast_response.body))
    end

    # Build or get an HTTP connection object.
    def connection
      @connection ||= Faraday.new(request: { timeout: ForecastIO.timeout })
    end

    # Set an HTTP connection object.
    #
    # @param connection Connection object to be used.
    attr_writer :connection

    private

    def get(path, params = {})
      params = ForecastIO.default_params.merge(params || {})

      connection.get(path, params)
    end
  end
end
