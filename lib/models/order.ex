defmodule Alpaca.Model.Order do
	use Alpaca.Client,
		path: "/orders",
		actions: [
			show: [
				http_verb: :get,
				query: [:status, :until, :limit, :nested]
			],
			index: [http_verb: :get, key: :order_id],
			place: [
				http_verb: :post,
				body: [
					:symbol, :qty, :sdie, :type, :time_in_force,
					:limit_price, :stop_price, :client_order_id,
					:order_class, :take_profit, :stop_loss,
					:trail_price, :trail_percent
				]
			],
			replace: [
				http_verb: :patch, 
				key: :order_id,
				body: [:qty, :limit_price, :stop_price, :time_in_force, :client_order_id]
			],
			cancel: [http_verb: :delete, key: :order_id],
			cancel_all: [http_verb: :delete],
		]
end
