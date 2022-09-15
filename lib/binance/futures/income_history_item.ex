defmodule Binance.Futures.IncomeHistoryItem do
  defstruct [
    :symbol,
    :income_type,
    :income,
    :asset,
    :info,
    :time,
    :tran_id,
    :trade_id
  ]

  use ExConstructor
end
