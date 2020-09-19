defmodule Alpaca.Model.LastQuote do
	use Alpaca.Client,
		version: "v1",
		host: :alpaca_data_host,
		path: "/last_quote/stocks",
		actions: [
			index: [http_verb: :get, key: :symbol]
		]
end