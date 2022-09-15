defmodule Binance.Futures.PositionMarginChangeHistoryItem do
  defstruct [
    :amount,
    :asset,
    :symbol,
    :time,
    :type,
    :position_side
  ]

  use ExConstructor
end
