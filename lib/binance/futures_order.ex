defmodule Binance.FuturesOrder do
  @moduledoc """
  """

  defstruct [
    :client_order_id,
    :cum_qty,
    :cum_quote,
    :executed_qty,
    :order_id,
    :avg_price,
    :orig_qty,
    :price,
    :reduce_only,
    :side,
    :position_side,
    :status,
    :stop_price,
    :close_position,
    :symbol,
    :time_in_force,
    :type,
    :orig_type,
    :activate_price,
    :price_rate,
    :update_time,
    :working_type,
    :price_protect
  ]

  use ExConstructor
end
