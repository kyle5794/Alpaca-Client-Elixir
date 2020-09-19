defmodule Alpaca.Tests.Models.LastTrade do
	use ExUnit.Case

	alias Alpaca.Mock.Mojito

	setup_all do
		Alpaca.Client.setup()
	end

	test "get last trade success" do
		Mojito.reply(200, ~s({"status":"success","symbol":"AAPL","last":{"price":347.71,"size":100,"exchange":2,"cond1":12,"cond2":0,"cond3":0,"cond4":0,"timestamp":1592600755847000064}}))
		{:ok, trade} = Alpaca.Model.LastTrade.index(symbol: "AAPL")
		assert trade == %{
			status: "success",
			symbol: "AAPL",
			last: %{
				price: 347.71,
				size: 100,
				exchange: 2,
				cond1: 12,
				cond2: 0,
				cond3: 0,
				cond4: 0,
				timestamp: 1592600755847000064
			}
		}
	end
end