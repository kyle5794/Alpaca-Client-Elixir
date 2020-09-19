defmodule Alpaca.Model.Account.PortfolioHistory do
	use Alpaca.Client,
		path: "/account/portfolio/history",
		actions: [
			show: [
				http_verb: :get,
				query: [:period, :timeframe, :date_end, :extended_hours]
			]
		]
end
