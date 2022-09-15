defmodule Binance.Futures.OrderBook do
  defstruct [
    :_e,
    :_t,
    :asks,
    :bids,
    :last_update_id
  ]

  use ExConstructor
end
