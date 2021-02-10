# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :municipios,
  ecto_repos: [Municipios.Repo]

# Configures the endpoint
config :municipios, MunicipiosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EwGRR3z6cxa71BP9tN6FEHFIJG7RR/jxni/1vVDWS/FMM6BBX/I3Y94QBMSWe81l",
  render_errors: [view: MunicipiosWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Municipios.PubSub,
  live_view: [signing_salt: "xl3/F86h"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
