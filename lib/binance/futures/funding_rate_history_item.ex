defmodule Binance.Futures.FundingRateHistoryItem do
  defstruct [
    :symbol,
    :funding_rate,
    :funding_time
  ]

  use ExConstructor
end
