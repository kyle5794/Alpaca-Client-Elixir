defmodule Alpaca.Model.Account.Activity do
	use Alpaca.Client,
		path: "/account/activities",
		actions: [
			show: [
				http_verb: :get,
				query: [:activity_types, :date, :until, :after, :direction, :page_size]
			],
			index: [
				http_verb: :get,
				key: :type,
				query: [:activity_types, :date, :until, :after, :direction, :page_size]
			],
		]

end