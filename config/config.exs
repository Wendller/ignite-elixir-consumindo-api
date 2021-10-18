# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :tesla_challenge,
  ecto_repos: [TeslaChallenge.Repo]

config :tesla_challenge, TeslaChallenge.Repo, migration_primary_key: [type: :binary_id]

config :tesla_challenge, TeslaChallengeWeb.Auth.Guardian,
  issuer: "tesla_challenge",
  secret_key: "1hPdG2YrGzLzFPC+6EIe9RUERF3HW4DxZ6kCe1UzfpmLy3oiqLLXG1sMr1H5yXMu"

config :tesla_challenge, TeslaChallengeWeb.Auth.Pipeline,
  module: TeslaChallengeWeb.Auth.Guardian,
  error_handler: TeslaChallengeWeb.Auth.ErrorHandler

# Configures the endpoint
config :tesla_challenge, TeslaChallengeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: TeslaChallengeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: TeslaChallenge.PubSub,
  live_view: [signing_salt: "/1g98gfA"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :tesla_challenge, TeslaChallenge.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
