defmodule Binance.Futures.AutoCancelAllOpenOrdersResponse do
  defstruct [
    :countdown_time,
    :symbol
  ]

  use ExConstructor
end
