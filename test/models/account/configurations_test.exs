defmodule Alpaca.Tests.Models.Account.Configurations do
	use ExUnit.Case

	alias Alpaca.Mock.Mojito

	setup_all do
		Alpaca.Client.setup()
	end

	test "show configuration success" do
		Mojito.reply(200, ~s({"dtbp_check":"entry","no_shorting":false,"pdt_check":"entry","suspend_trade":false,"trade_confirm_email":"all"}))
		{:ok, configurations} = Alpaca.Model.Account.Configurations.show()
		assert configurations == %{dtbp_check: "entry", no_shorting: false, pdt_check: "entry", suspend_trade: false, trade_confirm_email: "all"}
	end
	
	test "update configuration success" do
		Mojito.reply(200, ~s({"dtbp_check":"entry","no_shorting":false,"pdt_check":"entry","suspend_trade":false,"trade_confirm_email":"all"}))
		{:ok, configurations} = Alpaca.Model.Account.Configurations.update(dtbp_check: "entry", no_shorting: false, pdt_check: "entry", suspend_trade: false, trade_confirm_email: "all")
		assert configurations == %{dtbp_check: "entry", no_shorting: false, pdt_check: "entry", suspend_trade: false, trade_confirm_email: "all"}
	end
end