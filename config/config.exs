# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :yaus,
  ecto_repos: [Yaus.Repo]

# Configures the endpoint
config :yaus, Yaus.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k0iTxAiBxmlDEppagCmfxe3e4puyEp4kW/LeQe+BHbsTMMfmjQtKmr8YNX9K4uE8",
  render_errors: [view: Yaus.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Yaus.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
