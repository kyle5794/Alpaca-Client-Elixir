defmodule Alpaca.Model.Asset do
	use Alpaca.Client,
		path: "/assets",
		actions: [
			show: [http_verb: :get, query: :status],
			index: [http_verb: :get, key: :symbol]
		]
end