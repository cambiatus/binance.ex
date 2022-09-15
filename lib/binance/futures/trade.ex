defmodule Binance.Futures.Trade do
  defstruct [
    :id,
    :price,
    :qty,
    :quote_qty,
    :time,
    :is_buyer_maker
  ]

  use ExConstructor
end
