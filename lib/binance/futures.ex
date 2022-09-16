defmodule Binance.Futures do
  alias Binance.Rest.Futures.HTTPClient

  @doc """
  Test Connectivity

  Test connectivity to the Rest API.

  ## Examples

      BinanceFutures.ping()
  """
  def ping(), do: HTTPClient.get_binance_unsigned("/fapi/v1/ping/", %{})

  @doc """
  Check Server Time

  ## Examples

      BinanceFutures.get_server_time()
  """
  def get_server_time(), do: HTTPClient.get_binance_unsigned("/fapi/v1/time", %{})

  @doc """
  Exchange Information

  ## Examples

      BinanceFutures.get_exchange_info()
  """
  def get_exchange_info(), do: HTTPClient.get_binance_unsigned("/fapi/v1/exchangeInfo", %{})

  @doc """
  Order Book

  ## Examples

      BinanceFutures.get_order_book("BTCUSDT")
  """
  def get_order_book(symbol, limit \\ 500),
    do: HTTPClient.get_binance_unsigned("/fapi/v1/depth", %{symbol: symbol, limit: limit})

  @doc """
  Recent Trades List

  ## Examples

      BinanceFutures.get_recent_trades_list("BTCUSDT")
  """
  def get_recent_trades_list(symbol, limit \\ 500),
    do: HTTPClient.get_binance_unsigned("/fapi/v1/trades", %{symbol: symbol, limit: limit})

  @doc """
  Old Trades Lookup (MARKET_DATA)

  This endpoint need your API key only, not the secret key.

  ## Examples

      BinanceFutures.get_historical_trades("BTCUSDT")
  """
  def get_historical_trades(symbol, limit \\ 500, from_id \\ nil) do
    arguments =
      %{
        symbol: symbol,
        limit: limit
      }
      |> with_optional_arg("fromId", from_id)

    HTTPClient.get_binance_unsigned("/fapi/v1/historicalTrades", arguments)
  end

  @doc """
  Compressed/Aggregate Trades List

  ## Examples

      BinanceFutures.get_compressed_aggregate_trades_list("BTCUSDT")
  """
  def get_compressed_aggregate_trades_list(
        symbol,
        limit \\ 500,
        from_id \\ nil,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"limit", limit},
        {"fromId", from_id},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/aggTrades", arguments)
  end

  @doc """
  Kline/Candlestick Data

  Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.get_klines("BTCUSDT", "1h")
  """
  def get_klines(
        symbol,
        interval,
        limit \\ nil,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, interval: interval}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/klines", arguments)
  end

  @doc """
  Index Price Kline/Candlestick Data

  Kline/candlestick bars for the index price of a pair. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.get_index_price_kline_candlestick_data("BTCUSDT", "1h")
  """
  def get_index_price_kline_candlestick_data(
        symbol,
        interval,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{pair: symbol, interval: interval}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/indexPriceKlines", arguments)
  end

  @doc """
  Continuous Contract Kline/Candlestick Data

  Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.get_continuous_contract_kline_candlestick_data("BTCUSDT", "PERPETUAL", "1h")
  """
  def get_continuous_contract_kline_candlestick_data(
        symbol,
        contract_type,
        interval,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{pair: symbol, contractType: contract_type, interval: interval}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/continuousKlines", arguments)
  end

  @doc """
  Get Funding Rate History

  Mark Price and Funding Rate

  Weight: 1

  ## Examples

      BinanceFutures.get_funding_rate_history()
  """
  def get_funding_rate_history(symbol \\ nil, limit \\ 100, start_time \\ nil, end_time \\ nil) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/fundingRate", arguments)
  end

  @doc """
  Mark Price

  Mark Price and Funding Rate

  Weight: 1

  ## Examples

      BinanceFutures.get_mark_price()
  """
  def get_mark_price(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/premiumIndex", arguments)
  end

  @doc """
  Mark Price Kline/Candlestick Data

  Kline/candlestick bars for the mark price of a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.get_mark_price_kline_candlestick_data("BTCUSDT", "1h")
  """
  def get_mark_price_kline_candlestick_data(
        symbol,
        interval,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, interval: interval}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/fapi/v1/markPriceKlines", arguments)
  end

  @doc """
  Symbol Order Book Ticker

  Best price/qty on the order book for a symbol or symbols.

  ## Examples

      BinanceFutures.get_symbol_order_book_ticker()
  """
  def get_symbol_order_book_ticker(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/ticker/bookTicker", arguments)
  end

  @doc """
  24hr Ticker Price Change Statistics

  24 hour rolling window price change statistics.

  Careful when accessing this with no symbol.

  Weight:

  1 for a single symbol;

  40 when the symbol parameter is omitted

  ## Examples

      BinanceFutures.get_ticker()
  """
  def get_ticker(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/ticker/24hr", arguments)
  end

  @doc """
  Symbol Price Ticker

  Latest price for a symbol or symbols.

  ## Examples

      BinanceFutures.get_ticker_price()
  """
  def get_ticker_price(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/ticker/price", arguments)
  end

  @doc """
  Open Interest

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_open_interest("BTCUSDT")
  """
  def get_open_interest(symbol),
    do: HTTPClient.get_binance_unsigned("/fapi/v1/openInterest", %{symbol: symbol})

  @doc """
  Top Trader Long/Short Ratio (Accounts)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_top_trader_long_short_ratio_accounts("BTCUSDT", "1h")
  """
  def get_top_trader_long_short_ratio_accounts(
        symbol,
        period,
        limit \\ 30,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, period: period}
      |> with_optional_args([{"limit", limit}, {"startTime", start_time}, {"endTime", end_time}])

    HTTPClient.get_binance_unsigned("/futures/data/topLongShortAccountRatio", arguments)
  end

  @doc """
  Open Interest Statistics

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_open_interest_statistics("BTCUSDT", "1h")
  """
  def get_open_interest_statistics(
        symbol,
        period,
        limit \\ 30,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, period: period}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time}
      ])

    HTTPClient.get_binance_unsigned("/futures/data/openInterestHist", arguments)
  end

  @doc """
  Top Trader Long/Short Ratio (Positions)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_top_trader_long_short_ratio_positions("BTCUSDT", "1h")
  """
  def get_top_trader_long_short_ratio_positions(
        symbol,
        period,
        limit \\ 30,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, period: period}
      |> with_optional_args([{"limit", limit}, {"startTime", start_time}, {"endTime", end_time}])

    HTTPClient.get_binance_unsigned("/futures/data/topLongShortPositionRatio", arguments)
  end

  @doc """
  Taker Buy/Sell Volume

  ## Examples

      BinanceFutures.get_taker_buy_sell_volume("BTCUSDT", "1h")
  """
  def get_taker_buy_sell_volume(symbol, period, limit \\ 30, start_time \\ nil, end_time \\ nil) do
    arguments =
      %{symbol: symbol, period: period}
      |> with_optional_args([{"limit", limit}, {"startTime", start_time}, {"endTime", end_time}])

    HTTPClient.get_binance_unsigned("/futures/data/takerlongshortRatio", arguments)
  end

  @doc """
  Long/Short Ratio

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_long_short_ratio("BTCUSDT", "1h")
  """
  def get_long_short_ratio(symbol, period, limit \\ 30, start_time \\ nil, end_time \\ nil) do
    arguments =
      %{symbol: symbol, period: period}
      |> with_optional_args([{"limit", limit}, {"startTime", start_time}, {"endTime", end_time}])

    HTTPClient.get_binance_unsigned("/futures/data/globalLongShortAccountRatio", arguments)
  end

  @doc """
  Historical BLVT NAV Kline/Candlestick

  ## Examples

      BinanceFutures.get_historical_BLVT_NAV_kline_candlestick("BTCUSDT", "1h")
  """
  def get_historical_BLVT_NAV_kline_candlestick(
        symbol,
        interval,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil
      ) do
    arguments =
      %{symbol: symbol, interval: interval}
      |> with_optional_args([{"limit", limit}, {"startTime", start_time}, {"endTime", end_time}])

    HTTPClient.get_binance_unsigned("/fapi/v1/lvtKlines", arguments)
  end

  @doc """
  Composite Index Symbol Information

  ## Examples

      BinanceFutures.get_composite_index_symbol_information()
  """
  def get_composite_index_symbol_information(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/indexInfo", arguments)
  end

  @doc """
  Multi-Assets Mode Asset Index

  ## Examples

      BinanceFutures.get_multi_assets_mode_asset_index()
  """
  def get_multi_assets_mode_asset_index(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_arg("symbol", symbol)

    HTTPClient.get_binance_unsigned("/fapi/v1/assetIndex", arguments)
  end

  @doc """
  Account information

  ## Examples

      BinanceFutures.get_account()
  """
  def get_account(receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.get_binance("/fapi/v2/account", arguments)
  end

  @doc """
  Get Income History

  ## Examples

      BinanceFutures.get_income_history()
  """
  def get_income_history(
        symbol \\ nil,
        income_type \\ nil,
        limit \\ 100,
        start_time \\ nil,
        end_time \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"incomeType", income_type},
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/income", arguments)
  end

  @doc """
  Position Information

  ## Examples

      BinanceFutures.get_position_information()
  """
  def get_position_information(symbol \\ nil, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v2/positionRisk", arguments)
  end

  @doc """
  Account Trade List

  ## Examples

      BinanceFutures.get_account_trade_list("BTCUSDT")
  """
  def get_account_trade_list(
        symbol,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil,
        from_id \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time},
        {"fromId", from_id},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/userTrades", arguments)
  end

  @doc """
  Future Account Balance

  ## Examples

      BinanceFutures.future_account_balance()
  """
  def future_account_balance(receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.get_binance("/fapi/v2/balance", arguments)
  end

  @doc """
  Notional and Leverage Brackets (USER_DATA)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.get_notional_and_leverage_brackets()
  """
  def get_notional_and_leverage_brackets(symbol \\ nil, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/leverageBracket", arguments)
  end

  @doc """
  Position ADL Quantile Estimation (USER_DATA)

  ## Examples

      BinanceFutures.get_position_ADL_quantile_estimation()
  """
  def get_position_ADL_quantile_estimation(symbol \\ nil, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/adlQuantile", arguments)
  end

  @doc """
  User Commission Rate (USER_DATA)

  ## Examples

      BinanceFutures.get_user_commission_rate("BTCUSDT")
  """
  def get_user_commission_rate(symbol, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/commissionRate", arguments)
  end

  @doc """
  Change Multi-Assets Mode

  ## Examples

      BinanceFutures.change_multi_assets_mode("true")
  """
  def change_multi_assets_mode(multi_assets_margin, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{multiAssetsMargin: multi_assets_margin}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/multiAssetsMargin", arguments)
  end

  @doc """
  Get Current Multi-Assets Mode

  ## Examples

      BinanceFutures.get_current_multi_assets_mode()
  """
  def get_current_multi_assets_mode(receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.get_binance("/fapi/v1/multiAssetsMargin", arguments)
  end

  @doc """
  New Order (TRADE)

  https://binance-docs.github.io/apidocs/futures/en/#new-order-trade

  ## Examples

      BinanceFutures.new_order(%OrderInput{symbol: "BTCUSDT", side: "BUY", type: "MARKET", quantity: 1})
  """
  def new_order(
        %Binance.Futures.OrderInput{} = order_input,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      order_input
      |> Map.from_struct()
      |> Enum.filter(fn {_, v} -> !is_nil(v) end)
      |> Enum.into(%{})
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/order", arguments)
  end

  @doc """
  Query Order

  ## Examples

      BinanceFutures.get_order("BTCUSDT", 123456)
  """
  def get_order(
        symbol,
        order_id \\ nil,
        orig_client_order_id \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"orderId", order_id},
        {"origClientOrderId", orig_client_order_id},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/order", arguments)
  end

  @doc """
  Cancel Order

  ## Examples

      BinanceFutures.cancel_order("BTCUSDT", 123456)
  """
  def cancel_order(symbol, order_id \\ nil, orig_client_order_id \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"orderId", order_id},
        {"origClientOrderId", orig_client_order_id},
        {"timestamp", timestamp}
      ])

    HTTPClient.delete_binance("/fapi/v1/order", arguments)
  end

  @doc """
  Place Multiple Orders (TRADE)

  ## Examples

      BinanceFutures.place_multiple_orders([{type: "LIMIT", timeInForce: "GTC", symbol: "BTCUSDT", side: "BUY", price: "10001", quantity: "0.001"}])
  """
  def place_multiple_orders(batch_orders, receive_window \\ nil, timestamp \\ nil) do
    batch_orders =
      batch_orders
      |> Enum.map(fn order ->
        Enum.map(
          order,
          fn {k, v} -> {Recase.to_camel(k), v} end
        )
      end)

    arguments =
      %{batchOrders: batch_orders}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/batchOrders", arguments)
  end

  @doc """
  Cancel All Open Orders

  ## Examples

      BinanceFutures.cancel_all_open_orders("BTCUSDT")
  """
  def cancel_all_open_orders(symbol, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.delete_binance("/fapi/v1/allOpenOrders", arguments)
  end

  @doc """
  Auto-Cancel All Open Orders (TRADE)

  ## Examples

      BinanceFutures.auto_cancel_all_open_orders("BTCUSDT", 1000)
  """
  def auto_cancel_all_open_orders(symbol, countdown_time, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol, countdownTime: countdown_time}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/countdownCancelAll", arguments)
  end

  @doc """
  Current All Open Orders (USER_DATA)

  ## Examples

      BinanceFutures.get_all_open_orders()
  """
  def get_all_open_orders(symbol \\ nil, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/openOrders", arguments)
  end

  @doc """
  Cancel Multiple Orders (TRADE)

  ## Examples

      BinanceFutures.cancel_multiple_orders("BTCUSDT", [12345, 56789])
  """
  def cancel_multiple_orders(
        symbol,
        order_id_list \\ nil,
        orig_client_order_id_list \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"orderIdList", order_id_list},
        {"origClientOrderIdList", orig_client_order_id_list},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.delete_binance("/fapi/v1/batchOrders", arguments)
  end

  @doc """
  Query Current Open Order (USER_DATA)

  ## Examples

      BinanceFutures.get_current_open_order("BTCUSDT")
  """
  def get_current_open_order(
        symbol,
        order_id \\ nil,
        orig_client_order_id \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"orderId", order_id},
        {"origClientOrderId", orig_client_order_id},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/openOrder", arguments)
  end

  @doc """
  User's Force Orders (USER_DATA)

  ## Examples

      BinanceFutures.user_force_orders()
  """
  def user_force_orders(
        symbol \\ nil,
        auto_close_type \\ nil,
        limit \\ nil,
        start_time \\ nil,
        end_time \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"autoCloseType", auto_close_type},
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time},
        {"receiveWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/forceOrders", arguments)
  end

  @doc """
  All Orders

  ## Examples

      BinanceFutures.get_all_orders("BTCUSDT")
  """
  def get_all_orders(
        symbol,
        order_id \\ nil,
        limit \\ 500,
        start_time \\ nil,
        end_time \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"orderId", order_id},
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/allOrders", arguments)
  end

  @doc """
  Change Initial Leverage

  ## Examples

      BinanceFutures.change_initial_leverage("BTCUSDT", 10)
  """
  def change_initial_leverage(symbol, leverage, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol, leverage: leverage}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/leverage", arguments)
  end

  @doc """
  Change Margin Type

  ## Examples

      BinanceFutures.change_margin_type("BTCUSDT", "ISOLATED")
  """
  def change_margin_type(symbol, margin_type, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{symbol: symbol, marginType: margin_type}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/marginType", arguments)
  end

  @doc """
  Change Position Mode（TRADE）

  ## Examples

      BinanceFutures.change_position_mode("true")
  """
  def change_position_mode(dual_side_position, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{dualSidePosition: dual_side_position}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/positionSide/dual", arguments)
  end

  @doc """
  Get Position Margin Change History

  ## Examples

      BinanceFutures.get_postion_margin_change_history("BTCUSDT")
  """
  def get_position_margin_change_history(
        symbol,
        type \\ nil,
        limit \\ nil,
        start_time \\ nil,
        end_time \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol}
      |> with_optional_args([
        {"type", type},
        {"limit", limit},
        {"startTime", start_time},
        {"endTime", end_time},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/positionMargin/history", arguments)
  end

  @doc """
  Modify Isolated Position Margin

  ## Examples

      BinanceFutures.modify_isolated_position_margin("BTCUSDT", , "LIMIT")
  """
  def modify_isolated_position_margin(
        symbol,
        amount,
        type,
        position_side \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{symbol: symbol, amount: amount, type: type}
      |> with_optional_args([
        {"positionSide", position_side},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.post_binance("/fapi/v1/positionMargin", arguments)
  end

  @doc """
  Change Multi-Assets Mode (TRADE)

  ## Examples

      BinanceFutures.change_multi_assets_mode_TRADE("true")
  """
  def change_multi_assets_mode_TRADE(multi_assets_margin, receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{multiAssetsMargin: multi_assets_margin}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.post_binance("/fapi/v1/multiAssetsMargin", arguments)
  end

  @doc """
  Get Current Position Mode（USER_DATA）

  ## Examples

      BinanceFutures.get_current_position_mode()
  """
  def get_current_position_mode(receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.get_binance("/fapi/v1/positionSide/dual", arguments)
  end

  @doc """
  User API Trading Quantitative Rules Indicators (USER_DATA)

  ## Examples

      BinanceFutures.get_trading_quantitative_rules_indicators()
  """
  def get_trading_quantitative_rules_indicators(
        symbol \\ nil,
        receive_window \\ nil,
        timestamp \\ nil
      ) do
    arguments =
      %{}
      |> with_optional_args([
        {"symbol", symbol},
        {"recvWindow", receive_window},
        {"timestamp", timestamp}
      ])

    HTTPClient.get_binance("/fapi/v1/apiTradingStatus", arguments)
  end

  @doc """
  Get Current Multi-Assets Mode (USER_DATA)

  ## Examples

      BinanceFutures.get_current_multi_assets_mode_USER_DATA()
  """
  def get_current_multi_assets_mode_USER_DATA(receive_window \\ nil, timestamp \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"recvWindow", receive_window}, {"timestamp", timestamp}])

    HTTPClient.get_binance("/fapi/v1/multiAssetsMargin", arguments)
  end

  @doc """
  Create New Listen Key

  ## Examples

      BinanceFutures.create_listen_key()
  """
  def create_listen_key(), do: HTTPClient.post_binance_unsigned("/fapi/v1/listenKey", %{})

  @doc """
  Renew Listen Key

  ## Examples

      BinanceFutures.keep_alive_listen_key()
  """
  def keep_alive_listen_key(), do: HTTPClient.put_binance_unsigned("/fapi/v1/listenKey", %{})

  @doc """
  Delete Listen Key

  ## Examples

      BinanceFutures.close_listen_key()
  """
  def close_listen_key(), do: HTTPClient.delete_binance_unsigned("/fapi/v1/listenKey", %{})

  @doc """
  Portfolio Margin Exchange Information

  ## Examples

      BinanceFutures.portfolio_margin_exchange_information()
  """
  def portfolio_margin_exchange_information(symbol \\ nil) do
    arguments =
      %{}
      |> with_optional_args([{"symbol", symbol}])

    HTTPClient.get_binance_unsigned("/fapi/v1/pmExchangeInfo", arguments)
  end

  defp with_optional_arg(args, optional_arg_name, optional_arg) do
    args
    |> Map.merge(
      unless(is_nil(optional_arg),
        do: %{optional_arg_name => optional_arg},
        else: %{}
      )
    )
  end

  defp with_optional_args(args, optional_args) do
    Enum.reduce(optional_args, args, fn {key, value}, acc ->
      with_optional_arg(acc, key, value)
    end)
  end
end
