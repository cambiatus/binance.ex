defmodule Binance.Futures.PositionInformation do
  defstruct [
    :entry_price,
    :margin_type,
    :is_auto_add_margin,
    :isolated_margin,
    :leverage,
    :liquidation_price,
    :mark_price,
    :max_notional_value,
    :position_amt,
    :notional,
    :isolated_wallet,
    :symbol,
    :unrealized_profit,
    :position_side,
    :update_time
  ]

  use ExConstructor
end
