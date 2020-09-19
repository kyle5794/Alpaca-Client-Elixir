defmodule Alpaca.Mock.Mojito do
	import ExUnit.Assertions
	alias __MODULE__, as: State

	@name __MODULE__

	@enforce_keys [:captured, :replies]
	defstruct @enforce_keys

	@type t :: %State{
		replies: [],
		captured: [],
	}

	def child_spec([]) do
		%{
			id: __MODULE__,
			start: {__MODULE__, :start_link, []}
		}
	end

	def start_link() do
		Agent.start_link(fn -> initial_state() end, name: @name)
	end

	def clear() do
		Agent.cast(@name, fn _ -> initial_state() end)
	end

	def request(method, url, headers, body) do
		request = %Mojito.Request {
			url: url,
			method: method,
			headers: headers,
			body: body,
			opts: nil
		}

		Agent.get_and_update(@name, fn
			%{replies: [reply | replies]} = state ->
				{reply, %State{state |
					replies: replies,
					captured: state.captured ++ [request]
				}}
			_ -> flunk("mojito request made to '#{method} #{request.url}' but no mock reply was defined")
		end)
	end

	def error(reason) do
		ensure_started()
		Agent.update(@name, fn state ->
			%State{state | replies: state.replies ++ [{:error, reason}]}
		end)
	end

	def reply(code, body) when is_map(body) do
		reply(code, Jason.encode!(body))
	end

	def reply(code, body) do
		# currently version and status-line aren't needed
		reply = {:ok, %Mojito.Response{status_code: code, body: :binary.bin_to_list(body)}}
		ensure_started()
		Agent.update(@name, fn state ->
			%State{state | replies: state.replies ++ [reply]}
		end)
	end

	defp initial_state() do
		%State{captured: [], replies: []}
	end

	defp ensure_started() do
		if Process.whereis(@name) == nil do
			{:ok, _} = start_link()
		end
	end
end
