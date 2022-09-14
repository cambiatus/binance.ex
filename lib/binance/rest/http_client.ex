defmodule Binance.Rest.HTTPClient do
  @default_options [
    secret_key: Application.compile_env(:binance, :secret_key),
    api_key: Application.compile_env(:binance, :api_key),
    base_url: Application.compile_env(:binance, :end_point)
  ]

  def get_binance(endpoint, params \\ %{}, options \\ []),
    do: make_signed_request(endpoint, :get, params, options)

  def get_binance_unsigned(endpoint, params \\ %{}, options \\ []),
    do: make_unsigned_request(endpoint, :get, params, options)

  def delete_binance(endpoint, params \\ %{}, options \\ []),
    do: make_signed_request(endpoint, :delete, params, options)

  def delete_binance_unsigned(endpoint, params \\ %{}, options \\ []),
    do: make_unsigned_request(endpoint, :delete, params, options)

  def post_binance(endpoint, params \\ %{}, options \\ []),
    do: make_signed_request(endpoint, :post, params, options, "")

  def post_binance_unsigned(endpoint, params \\ %{}, options \\ []),
    do: make_unsigned_request(endpoint, :post, params, options, "")

  def put_binance_unsigned(endpoint, params \\ %{}, options \\ []),
    do: make_unsigned_request(endpoint, :put, params, options, "")

  defp make_unsigned_request(endpoint, method, params, options, body \\ nil) do
    options =
      Keyword.merge(@default_options, options)
      |> Enum.into(%{})

    headers = [{"X-MBX-APIKEY", options.api_key}]

    full_url = "#{options.base_url}#{endpoint}?#{URI.encode_query(params)}"

    args =
      case body do
        nil -> [full_url, headers]
        _ -> [full_url, body, headers]
      end

    apply(HTTPoison, method, args)
    |> parse_response
  end

  defp make_signed_request(
         endpoint,
         method,
         params,
         options,
         body \\ nil
       ) do
    options =
      Keyword.merge(@default_options, options)
      |> Enum.into(%{})

    case validate_credentials(options.secret_key, options.api_key) do
      {:error, _} = error ->
        error

      :ok ->
        headers = [{"X-MBX-APIKEY", options.api_key}]
        receive_window = 5000
        timestamp = DateTime.utc_now() |> DateTime.to_unix(:millisecond)

        params =
          Map.merge(params, %{
            timestamp: timestamp,
            recvWindow: receive_window
          })

        argument_string = URI.encode_query(params)

        signature =
          generate_signature(:sha256, options.secret_key, argument_string)
          |> Base.encode16()

        full_url = "#{options.base_url}#{endpoint}?#{argument_string}&signature=#{signature}"

        args =
          case body do
            nil -> [full_url, headers]
            _ -> [full_url, body, headers]
          end

        apply(HTTPoison, method, args)
        |> parse_response
    end
  end

  defp validate_credentials(nil, nil),
    do: {:error, {:config_missing, "Secret and API key missing"}}

  defp validate_credentials(nil, _api_key),
    do: {:error, {:config_missing, "Secret key missing"}}

  defp validate_credentials(_secret_key, nil),
    do: {:error, {:config_missing, "API key missing"}}

  defp validate_credentials(_secret_key, _api_key),
    do: :ok

  defp parse_response({:ok, response}) do
    response.body
    |> Poison.decode()
    |> parse_response_body
  end

  defp parse_response({:error, err}) do
    {:error, {:http_error, err}}
  end

  defp parse_response_body({:ok, data}) do
    case data do
      %{"code" => _c, "msg" => _m} = error -> {:error, error}
      _ -> {:ok, data}
    end
  end

  defp parse_response_body({:error, err}) do
    {:error, {:poison_decode_error, err}}
  end

  # TODO: remove when we require OTP 22.1
  if Code.ensure_loaded?(:crypto) and function_exported?(:crypto, :mac, 4) do
    defp generate_signature(digest, key, argument_string),
      do: :crypto.mac(:hmac, digest, key, argument_string)
  else
    defp generate_signature(digest, key, argument_string),
      do: :crypto.hmac(digest, key, argument_string)
  end
end
