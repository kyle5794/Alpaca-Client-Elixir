defmodule Alpaca.Client do
	if Mix.env() == :test do
		@http Alpaca.Mock.Mojito
	else
		@http Mojito
	end

	defmacro __using__(opts \\ []) do
		

		host_key = Keyword.get(opts, :host, :alpaca_api_host)
		version = Keyword.get(opts, :version, "v2")
		path = Keyword.get(opts, :path)
		funcs = List.wrap(Keyword.get(opts, :actions))
		for {name, func_opts} <- funcs do
			key_name = Keyword.get(func_opts, :key)
			action = Keyword.get(func_opts, :http_verb)
			body_keys = List.wrap(Keyword.get(func_opts, :body))
			query_keys = List.wrap(Keyword.get(func_opts, :query))
			quote location: :keep do
				alias Alpaca.Client

				def unquote(name)(req_opts \\ []) when unquote(action) in [:get, :put, :post, :patch, :delete] do
					[headers: headers, host: host] = :persistent_term.get(unquote(host_key))
					query = 
					url =
						[host, "/", unquote(version), unquote(path)]
						|> Client.add_path(req_opts, unquote(key_name))
						|> Client.add_query(req_opts, unquote(query_keys))
						|> Client.i2b()

					body = Client.build_body(req_opts, unquote(body_keys))

					unquote(action)
					|> unquote(@http).request(url, headers, body)
					|> Client.handle_resp()
				end
			end
		end
	end

	def add_path(url, _req_opts, nil), do: url
	def add_path(url, req_opts, key_name) do
		case Keyword.get(req_opts, key_name) do
			nil -> raise ArgumentError, message: "missing argument #{Atom.to_string(key_name)}"
			key -> [url, "/", key]
		end
	end

	def add_query(url, req_opts, query_keys) do
		case build_map(req_opts, query_keys) do
			nil -> url
			query -> [url, "?", URI.encode_query(query)]
		end
	end

	def build_body(req_opts, body_keys) do
		Jason.encode!(build_map(req_opts, body_keys))
	end

	def build_map(_req_opts, nil), do: nil
	def build_map([], _keys), do: nil
	def build_map(_req_opts, []), do: nil
	def build_map(nil, _keys), do: nil
	def build_map(req_opts, keys) do
		Enum.reduce(keys, %{}, fn key, acc ->
			case Keyword.get(req_opts, key) do
				nil -> acc
				val -> Map.put(acc, Atom.to_string(key), val)
			end
		end)
	end

	def handle_resp({:ok, %Mojito.Response{status_code: status, body: body} = _resp}) when status < 300 do
		{:ok, Jason.decode!(body, keys: :atoms)}
	end

	def handle_resp({:ok, %Mojito.Response{status_code: status, body: body} = _resp}) when status >= 300 do
		{:error, status, body}
	end

	def handle_resp({:error, err}), do: {:error, err}
	def handle_resp(err), do: {:error, err}

	def i2b(iolist), do: IO.iodata_to_binary(iolist)

	def setup() do
		alpaca = Application.fetch_env!(:alpaca, :client)
		headers = [
			{"APCA-API-KEY-ID", alpaca[:api_id]},
			{"APCA-API-SECRET-KEY", alpaca[:api_secret]}
		]
		host = alpaca[:host]
		data_url = alpaca[:data_url]
		:persistent_term.put(:alpaca_api_host, headers: headers, host: host)
		:persistent_term.put(:alpaca_data_host, headers: headers, host: data_url)
	end

end