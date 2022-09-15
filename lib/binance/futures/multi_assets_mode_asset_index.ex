defmodule Binance.Futures.MultiAssetsModeAssetIndex do
  defstruct [
    :symbol,
    :time,
    :index,
    :bid_buffer,
    :ask_buffer,
    :bid_rate,
    :ask_rate,
    :auto_exchange_bid_buffer,
    :auto_exchange_ask_buffer,
    :auto_exchange_bid_rate,
    :auto_exchange_ask_rate
  ]

  use ExConstructor
end
