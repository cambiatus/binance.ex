defmodule Binance.Futures.AccountTrade do
  defstruct [
    :buyer,
    :commission,
    :commission_asset,
    :id,
    :maker,
    :order_id,
    :price,
    :qty,
    :quote_qty,
    :realized_pnl,
    :side,
    :position_side,
    :symbol,
    :time
  ]

  use ExConstructor
end
