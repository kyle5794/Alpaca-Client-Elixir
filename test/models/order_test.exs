defmodule Alpaca.Tests.Models.Order do
	use ExUnit.Case

	alias Alpaca.Mock.Mojito

	setup_all do
		Alpaca.Client.setup()
	end

	test "show order success" do
		Mojito.reply(200, ~s([{"id":"ebfc1c74-fd4a-46e1-b4e7-7f6f8ab1ef7a","client_order_id":"e08ad98f-07a4-40a8-9b6e-7186b0b7dd8d","created_at":"2020-05-24T01:08:24.888924Z","updated_at":"2020-05-24T01:08:24.888924Z","submitted_at":"2020-05-24T01:08:24.881019Z","filled_at":null,"expired_at":null,"canceled_at":null,"failed_at":null,"replaced_at":null,"replaced_by":null,"replaces":null,"asset_id":"b0b6dd9d-8b9b-48a9-ba46-b9d54906e415","symbol":"AAPL","asset_class":"us_equity","qty":"1","filled_qty":"0","filled_avg_price":null,"order_class":"","order_type":"market","type":"market","side":"buy","time_in_force":"day","limit_price":null,"stop_price":null,"status":"accepted","extended_hours":false,"legs":null}]))
		{:ok, order} = Alpaca.Model.Order.show(status: "all")
		assert order == [%{
			id: "ebfc1c74-fd4a-46e1-b4e7-7f6f8ab1ef7a",
			client_order_id: "e08ad98f-07a4-40a8-9b6e-7186b0b7dd8d",
			created_at: "2020-05-24T01:08:24.888924Z",
			updated_at: "2020-05-24T01:08:24.888924Z",
			submitted_at: "2020-05-24T01:08:24.881019Z",
			filled_at: nil,
			expired_at: nil,
			canceled_at: nil,
			failed_at: nil,
			replaced_at: nil,
			replaced_by: nil,
			replaces: nil,
			asset_id: "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415", 
			symbol: "AAPL",
			asset_class: "us_equity",
			qty: "1",
			filled_qty: "0",
			filled_avg_price: nil,
			order_class: "",
			order_type: "market",
			type: "market",
			side: "buy",
			time_in_force: "day",
			limit_price: nil,
			stop_price: nil,
			status: "accepted",
			extended_hours: false,
			legs: nil
		}]
	end

	test "get order by id" do
		Mojito.reply(200, ~s([{"id":"ebfc1c74-fd4a-46e1-b4e7-7f6f8ab1ef7a","client_order_id":"e08ad98f-07a4-40a8-9b6e-7186b0b7dd8d","created_at":"2020-05-24T01:08:24.888924Z","updated_at":"2020-05-24T01:08:24.888924Z","submitted_at":"2020-05-24T01:08:24.881019Z","filled_at":null,"expired_at":null,"canceled_at":null,"failed_at":null,"replaced_at":null,"replaced_by":null,"replaces":null,"asset_id":"b0b6dd9d-8b9b-48a9-ba46-b9d54906e415","symbol":"AAPL","asset_class":"us_equity","qty":"1","filled_qty":"0","filled_avg_price":null,"order_class":"","order_type":"market","type":"market","side":"buy","time_in_force":"day","limit_price":null,"stop_price":null,"status":"accepted","extended_hours":false,"legs":null}]))
		{:ok, order} = Alpaca.Model.Order.index(order_id: "ebfc1c74-fd4a-46e1-b4e7-7f6f8ab1ef7a")
		assert order == [%{
			id: "ebfc1c74-fd4a-46e1-b4e7-7f6f8ab1ef7a",
			client_order_id: "e08ad98f-07a4-40a8-9b6e-7186b0b7dd8d",
			created_at: "2020-05-24T01:08:24.888924Z",
			updated_at: "2020-05-24T01:08:24.888924Z",
			submitted_at: "2020-05-24T01:08:24.881019Z",
			filled_at: nil,
			expired_at: nil,
			canceled_at: nil,
			failed_at: nil,
			replaced_at: nil,
			replaced_by: nil,
			replaces: nil,
			asset_id: "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415", 
			symbol: "AAPL",
			asset_class: "us_equity",
			qty: "1",
			filled_qty: "0",
			filled_avg_price: nil,
			order_class: "",
			order_type: "market",
			type: "market",
			side: "buy",
			time_in_force: "day",
			limit_price: nil,
			stop_price: nil,
			status: "accepted",
			extended_hours: false,
			legs: nil
		}]
	end
end