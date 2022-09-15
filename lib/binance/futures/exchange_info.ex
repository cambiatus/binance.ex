defmodule Binance.Futures.ExchangeInfo do
  defstruct [
    :assets,
    :exchange_filters,
    :futures_type,
    :rate_limits,
    :server_time,
    :symbols,
    :timezone
  ]

  use ExConstructor
end
