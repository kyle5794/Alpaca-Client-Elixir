import Config

config :alpaca, :client,
	api_id: "api-id",
	api_secret: "api-secrete",
	host: "host-url",
	data_url: "data-url",
	api_version: "v2"

config :mojito,
	timeout: 2500,
	pool_opts: [
		size: 10,
		destinations: [
			"https://paper-api.alpaca.markets": [
				size: 20,
				max_overflow: 20,
				pools: 10
			],
			"https://data.alpaca.markets": [
				size: 20,
				max_overflow: 20,
				pools: 10
			]
		]
	]
