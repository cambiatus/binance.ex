defmodule Binance.Futures.CommissionRate do
  defstruct [
    :maker_commission_rate,
    :symbol,
    :taker_commission_rate
  ]

  use ExConstructor
end
