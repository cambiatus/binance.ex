defmodule Binance.Futures.SymbolOrderBookTicker do
  defstruct [
    :symbol,
    :bid_price,
    :bid_qty,
    :ask_price,
    :ask_qty,
    :time
  ]

  use ExConstructor
end
