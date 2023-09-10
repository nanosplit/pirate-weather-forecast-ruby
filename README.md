# pirate_weather_forecast_io

[Pirate Weather forecast.io](https://pirateweather.net/en/latest/) API wrapper in Ruby, forked from
[Dark Sky's forecast.io](https://github.com/darkskyapp/forecast-ruby).

## Installation

`gem install forecast_io`

or in your `Gemfile`

```ruby
gem 'pirate_weather_forecast_io'
```

## Usage

Make sure you require the library.

```ruby
require 'pirate_weather_forecast_io'
```

You need to set an API key before you can make requests to the API. Grab one from
[Pirate Weather](https://pirateweather.net/en/latest/).

```ruby
ForecastIO.configure do |configuration|
  configuration.api_key = 'this-is-your-api-key'
end
```

Alternatively:

```ruby
ForecastIO.api_key = 'this-is-your-api-key'
```

You can then make requests to the `ForecastIO.forecast(latitude, longitude, options = {})` method.

Valid options in the `options` hash are:

* `:time` - Unix time in seconds.
* `:params` - Query parameters that can contain the following:
  * `:jsonp` - JSONP callback.
  * `:units` - Return the API response in SI units, rather than the default Imperial units.
  * `:exclude` - "Exclude some number of data blocks from the API response. This is useful for reducing latency and saving cache space. [blocks] should be a comma-delimeted list (without spaces) of any of the following: currently, minutely, hourly, daily, alerts, flags." (via Dark Sky's [v2 docs](https://developer.forecast.io/docs/v2#changelog))

Get the current forecast:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423)
```

Get the current forecast at a given time:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423, time: Time.new(2013, 3, 11).to_i)
```

Get the current forecast and use SI units:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423, params: { units: 'si' })
```

The `forecast(...)` method will return a response that you can interact with in a more-friendly way, such as:

```ruby
forecast = ForecastIO.forecast(37.8267, -122.423)
forecast.latitude
forecast.longitude
```

## Contributing

⏳

## [License](./LICENSE)

Copyright (c) 2023 Alex Cochran
