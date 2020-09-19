defmodule Alpaca.Model.LastTrade do
	use Alpaca.Client,
		version: "v1",
		host: :alpaca_data_host,
		path: "/last/stocks",
		actions: [
			index: [http_verb: :get, key: :symbol]
		]
end