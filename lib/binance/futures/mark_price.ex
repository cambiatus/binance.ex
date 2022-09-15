defmodule Binance.Futures.MarkPrice do
  defstruct [
    :symbol,
    :mark_price,
    :index_price,
    :estimated_settle_price,
    :last_funding_rate,
    :next_funding_time,
    :interest_rate,
    :time
  ]

  use ExConstructor
end
