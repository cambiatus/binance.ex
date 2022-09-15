defmodule Binance.Futures.ChangeInitialLeverageResponse do
  defstruct [
    :leverage,
    :max_notional_value,
    :symbol
  ]

  use ExConstructor
end
