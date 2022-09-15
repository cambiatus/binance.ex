defmodule Binance.Futures.LongShortRatio do
  defstruct [
    :symbol,
    :long_short_ratio,
    :long_account,
    :short_account,
    :timestamp
  ]

  use ExConstructor
end
