defmodule Binance.Futures.OpenInterest do
  defstruct [
    :open_interest,
    :symbol,
    :time
  ]

  use ExConstructor
end
