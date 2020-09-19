defmodule Alpaca.Model.Clock do
	use Alpaca.Client,
		path: "/clock",
		actions: [show: [http_verb: :get]]
end