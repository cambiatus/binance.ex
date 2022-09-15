defmodule Binance.Futures.SymbolPriceTicker do
  defstruct [
    :symbol,
    :price,
    :time
  ]

  use ExConstructor
end
