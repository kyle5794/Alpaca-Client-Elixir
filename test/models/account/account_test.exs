defmodule Alpaca.Tests.Models.Account do
	use ExUnit.Case

	alias Alpaca.Mock.Mojito

	setup_all do
		Alpaca.Client.setup()
	end

	test "show account success" do
		Mojito.reply(200, ~s({"id":"69cdc44a-b880-466f-aa65-ef12b7602a56","account_number":"PA2VISKATNVJ","status":"ACTIVE","currency":"USD","buying_power":"400152.36","regt_buying_power":"200076.18","daytrading_buying_power":"400152.36","cash":"100038.09","portfolio_value":"100038.09","pattern_day_trader":false,"trading_blocked":false,"transfers_blocked":false,"account_blocked":false,"created_at":"2020-07-31T02:29:07.547611Z","trade_suspended_by_user":false,"multiplier":"4","shorting_enabled":true,"equity":"100038.09","last_equity":"100038.09","long_market_value":"0","short_market_value":"0","initial_margin":"0","maintenance_margin":"0","last_maintenance_margin":"0","sma":"0","daytrade_count":0}))
		{:ok, account} = Alpaca.Model.Account.show()
		assert account.id == "69cdc44a-b880-466f-aa65-ef12b7602a56"
		assert account.account_number == "PA2VISKATNVJ"
	end

	test "show account failed" do
		Mojito.error("bad thing happened")
		{:error, err} = Alpaca.Model.Account.show()
		assert err == "bad thing happened"
	end
end