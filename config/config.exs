# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sales_admin,
  ecto_repos: [SalesAdmin.Repo]

# Configures the endpoint
config :sales_admin, SalesAdminWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Y2BLbUjdeKuZjQ4dTwzLGF9mAGwf1u+CT3ST+wAWU0WtfTBFTwSV9T31FuSwwvg6",
  render_errors: [view: SalesAdminWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SalesAdmin.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
