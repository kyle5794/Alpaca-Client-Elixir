defmodule Alpaca.Tests.Models.LastQuote do
	use ExUnit.Case

	alias Alpaca.Mock.Mojito

	setup_all do
		Alpaca.Client.setup()
	end

	test "get last quote success" do
		Mojito.reply(200, ~s({"status":"success","symbol":"AAPL","last":{"askprice":0,"asksize":0,"askexchange":0,"bidprice":0,"bidsize":0,"bidexchange":2,"timestamp":1593205454888000000}}))
		{:ok, last_quote} = Alpaca.Model.LastQuote.index(symbol: "AAPL")
		assert last_quote == %{
			status: "success",
			symbol: "AAPL",
			last: %{
				askprice: 0,
				asksize: 0,
				askexchange: 0,
				bidprice: 0,
				bidsize: 0,
				bidexchange: 2,
				timestamp: 1593205454888000000
			}
		}
	end
end