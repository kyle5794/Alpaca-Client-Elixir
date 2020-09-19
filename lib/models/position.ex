defmodule Alpaca.Model.Position do
	use Alpaca.Client,
		path: "/positions",
		actions: [
			show: [http_verb: :get],
			index: [http_verb: :get, key: :symbol],
			close_all: [http_verb: :delete],
			close: [http_verb: :delete, key: :symbol]
		]
end
