defmodule Binance.Futures.OpenInterestStatistics do
  defstruct [
    :symbol,
    :sum_open_interest,
    :sum_open_interest_value,
    :timestamp
  ]

  use ExConstructor
end
