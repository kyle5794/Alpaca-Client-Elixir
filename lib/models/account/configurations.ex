defmodule Alpaca.Model.Account.Configurations do
	use Alpaca.Client,
		path: "/account/configurations",
		actions: [
			show: [http_verb: :get],
			update: [
				http_verb: :patch,
				body: [:dtbp_check, :no_shorting, :trade_confirm_email, :trade_suspended_by_user]
			]
		]
end