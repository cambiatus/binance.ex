defmodule Binance.Futures.TakerBuySellVolume do
  defstruct [
    :buy_sell_ratio,
    :buy_vol,
    :sell_vol,
    :timestamp
  ]

  use ExConstructor
end
