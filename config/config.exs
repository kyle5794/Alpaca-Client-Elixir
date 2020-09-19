import Config

config :alpaca, client: "test only"

import_config "#{Mix.env()}.exs"
