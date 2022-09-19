defmodule Binance.Rest.Futures.HTTPClient do
  def get_binance(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.get_binance(endpoint, params, options)
  end

  def get_binance_unsigned(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.get_binance_unsigned(endpoint, params, options)
  end

  def delete_binance(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.delete_binance(endpoint, params, options)
  end

  def delete_binance_unsigned(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.delete_binance_unsigned(endpoint, params, options)
  end

  def post_binance(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.post_binance(endpoint, params, options)
  end

  def post_binance_unsigned(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.post_binance_unsigned(endpoint, params, options)
  end

  def put_binance_unsigned(endpoint, params \\ %{}, options \\ []) do
    options = fill_options(options)
    Binance.Rest.HTTPClient.put_binance_unsigned(endpoint, params, options)
  end

  defp fill_options(options) do
    Keyword.merge(
      [
        secret_key: Application.get_env(:binance, :futures_secret_key),
        api_key: Application.get_env(:binance, :futures_api_key),
        base_url: Application.get_env(:binance, :futures_end_point)
      ],
      options
    )
    |> Enum.into(%{})
  end
end
