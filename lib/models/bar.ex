defmodule Alpaca.Model.Bar do
	use Alpaca.Client,
		version: "v1",
		host: :alpaca_data_host,
		path: "/bars",
		actions: [
			show: [
				http_verb: :get,
				key: :time_frame,
				query: [:start_dt, :end_dt, :limit, :symbols]
			],
		]
end