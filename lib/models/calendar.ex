defmodule Alpaca.Model.Calendar do
	use Alpaca.Client,
		path: "/calendar",
		actions: [show: [http_verb: :get]]
end