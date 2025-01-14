# frozen_string_literal: true

require "spec_helper"

describe ForecastIO do
  describe ".default_params" do
    it "defaults to an empty hash" do
      expect(ForecastIO.default_params).to eq({})
    end
  end

  describe ".forecast" do
    before :each do
      ForecastIO.api_key = "this-is-an-api-key"
    end

    it "should return a forecast for a given latitude, longitude" do
      VCR.use_cassette("forecast_for_latitude_longitude", record: :once) do
        forecast = ForecastIO.forecast("37.8267", "-122.423")
        expect(forecast).to_not be_nil
        expect(forecast.latitude).to eq(37.8267)
        expect(forecast.longitude).to eq(-122.423)
        expect(forecast.daily.size).to eq(3)
        expect(forecast.alerts).to be_nil
      end
    end

    it "should return a forecast for a given latitude, longitude and time" do
      VCR.use_cassette("forecast_for_latitude_longitude_and_time") do
        forecast = ForecastIO.forecast("37.8267", "-122.423", time: Time.utc(2013, 3, 11, 4).to_i)
        expect(forecast).to_not be_nil
        expect(forecast.latitude).to eq(37.8267)
        expect(forecast.longitude).to eq(-122.423)
        expect(forecast.daily.size).to eq(1)
        expect(forecast.alerts).to be_nil
      end
    end

    it "should return a forecast for a given latitude, longitude and query params" do
      VCR.use_cassette("forecast_for_latitude_longitude_and_query_params") do
        forecast = ForecastIO.forecast("37.8267", "-122.423", params: { units: "si" })
        expect(forecast).to_not be_nil
        expect(forecast.latitude).to eq(37.8267)
        expect(forecast.longitude).to eq(-122.423)
        expect(forecast.daily.size).to eq(3)
        expect(forecast.alerts).to be_nil
      end
    end

    context "unit tests" do
      let(:faraday)  { double "Faraday", get: response }
      let(:response) { double "Response", success?: true, body: "{}" }

      before :each do
        stub_const "Faraday", double(new: faraday)

        allow(ForecastIO).to receive_messages(api_key: "abc123", connection: faraday)
      end

      context "without default parameters" do
        before :each do
          expect(ForecastIO).to receive_messages(default_params: {})
        end

        it "sends through a standard request" do
          expect(faraday).to receive(:get).with(
            "https://api.pirateweather.net/forecast/abc123/1.2,3.4", {}
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4)
        end

        it "sends through provided parameters" do
          expect(faraday).to receive(:get).with(
            "https://api.pirateweather.net/forecast/abc123/1.2,3.4", { units: "si" }
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: { units: "si" })
        end
      end

      context "with default parameters" do
        before :each do
          allow(ForecastIO).to receive_messages(default_params: { units: "si" })
        end

        it "sends through the default parameters" do
          expect(faraday).to receive(:get).with(
            "https://api.pirateweather.net/forecast/abc123/1.2,3.4", { units: "si" }
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4)
        end

        it "sends through the merged parameters" do
          expect(faraday).to receive(:get).with(
            "https://api.pirateweather.net/forecast/abc123/1.2,3.4",
            { units: "si", exclude: "daily" }
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: { exclude: "daily" })
        end

        it "overwrites default parameters when appropriate" do
          expect(faraday).to receive(:get).with(
            "https://api.pirateweather.net/forecast/abc123/1.2,3.4",
            { units: "imperial" }
          ).and_return(response)

          ForecastIO.forecast(1.2, 3.4, params: { units: "imperial" })
        end
      end
    end
  end
end
