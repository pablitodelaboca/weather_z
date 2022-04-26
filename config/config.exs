# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :weather, WeatherWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: WeatherWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Weather.PubSub,
  live_view: [signing_salt: "iy3+rl4n"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :weather, Weather.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Open weather map API key goes in here
# set your ENV VAR
# export WEATHER_API_KEY=KEY
weather_api_key =
  System.get_env("WEATHER_API_KEY") ||
    raise """
    environment variable WEATHER_API_KEY is missing.
    """

config :weather, api_key: weather_api_key
config :weather, base_api_data_url: "https://api.openweathermap.org/data/2.5"
config :weather, base_api_geo_url: "http://api.openweathermap.org/geo/1.0"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
