defmodule Binance.Futures.TickerPriceChangeStatistics do
  defstruct [
    :symbol,
    :price_change,
    :price_change_percent,
    :weighted_avg_price,
    :last_price,
    :last_qty,
    :open_price,
    :high_price,
    :low_price,
    :volume,
    :quote_volume,
    :open_time,
    :close_time,
    :first_id,
    :last_id,
    :count
  ]

  use ExConstructor
end
