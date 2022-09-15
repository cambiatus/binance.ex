defmodule Binance.Futures.OrderInput do
  @moduledoc """
  A struct to define values used to create an order. The struct only enforces some
  keys, but other keys may be required based on the `:type` key. See the [Binance
  API docs](https://binance-docs.github.io/apidocs/futures/en/#new-order-trade) for more information.
  """

  @enforce_keys [:symbol, :side, :type]
  defstruct [
    :symbol,
    :side,
    :type,
    :position_side,
    :time_in_force,
    :quantity,
    :reduce_only,
    :price,
    :new_client_order_id,
    :stop_price,
    :close_position,
    :activation_price,
    :callback_rate,
    :working_type,
    :price_protect,
    :new_order_resp_type
  ]

  use ExConstructor
end
