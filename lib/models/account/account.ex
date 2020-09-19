defmodule Alpaca.Model.Account do
	use Alpaca.Client,
		path: "/account",
		actions: [
			show: [http_verb: :get]
		]
end