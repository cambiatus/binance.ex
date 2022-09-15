defmodule Binance.Futures.CompositeIndexSymbolInfo do
  defstruct [
    :symbol,
    :time,
    :component,
    :base_asset_list
  ]

  use ExConstructor
end
