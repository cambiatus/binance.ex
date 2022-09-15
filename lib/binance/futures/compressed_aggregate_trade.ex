defmodule Binance.Futures.CompressedAggregateTrade do
  defstruct [
    :a,
    :p,
    :q,
    :f,
    :l,
    :T,
    :m
  ]

  use ExConstructor
end
