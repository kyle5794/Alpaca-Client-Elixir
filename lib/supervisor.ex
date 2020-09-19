defmodule Alpaca.Supervisor do
	use Application

	def start(_type, args) do
		children = case args do
			[env: :test] -> [Alpaca.Mock.Mojito]
			[_] -> []
		end

		Supervisor.start_link(children, strategy: :one_for_one)
	end
	
end