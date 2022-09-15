defmodule Binance.Futures.Account do
  defstruct [
    :assets,
    :available_balance,
    :can_deposit,
    :can_trade,
    :can_withdraw,
    :fee_tier,
    :max_withdraw_amount,
    :positions,
    :total_cross_un_pnl,
    :total_cross_wallet_balance,
    :total_initial_margin,
    :total_maint_margin,
    :total_margin_balance,
    :total_open_order_initial_margin,
    :total_position_initial_margin,
    :total_unrealized_profit,
    :total_wallet_balance,
    :update_time
  ]

  use ExConstructor
end
