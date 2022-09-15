defmodule Binance.Futures do
  alias Binance.Rest.HTTPClient

  @doc """
  Test Connectivity

  Test connectivity to the Rest API.

  ## Examples

      BinanceFutures.test_connectivity()
  """
  def test_connectivity() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/ping/",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Check Server Time

  ## Examples

      BinanceFutures.check_server_time()
  """
  def check_server_time() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/time",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, %{"serverTime" => time}} -> {:ok, time}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Exchange Information

  ## Examples

      BinanceFutures.exchange_information()
  """
  def exchange_information() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/exchangeInfo",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.ExchangeInfo.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Order Book

  ## Examples

      BinanceFutures.order_book("BTCUSDT")
  """
  def order_book(symbol) do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/depth",
           %{symbol: symbol},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.OrderBook.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Recent Trades List

  ## Examples

      BinanceFutures.recent_trades_list("BTCUSDT")
  """
  def recent_trades_list(symbol) do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/trades",
           %{symbol: symbol},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.Trade.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Old Trades Lookup (MARKET_DATA)

  This endpoint need your API key only, not the secret key.

  ## Examples

      BinanceFutures.old_trades_lookup("BTCUSDT")
  """
  def old_trades_lookup(symbol) do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/historicalTrades",
           %{symbol: symbol},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.Trade.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Compressed/Aggregate Trades List

  ## Examples

      BinanceFutures.compressed_aggregate_trades_list("BTCUSDT")
  """
  def compressed_aggregate_trades_list(symbol) do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/aggTrades",
           %{symbol: symbol},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.CompressedAggregateTrade.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Kline/Candlestick Data

  Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.kline_candlestick_data("BTCUSDT", "1h")
  """
  def kline_candlestick_data(symbol, interval) do
    HTTPClient.get_binance_unsigned(
      "/fapi/v1/klines",
      %{symbol: symbol, interval: interval},
      api_key: Application.get_env(:binance, :futures_api_key),
      secret_key: Application.get_env(:binance, :futures_secret_key),
      base_url: Application.get_env(:binance, :futures_end_point)
    )
  end

  @doc """
  Index Price Kline/Candlestick Data

  Kline/candlestick bars for the index price of a pair. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.index_price_kline_candlestick_data("BTCUSDT", "1h")
  """
  def index_price_kline_candlestick_data(pair, interval) do
    HTTPClient.get_binance_unsigned(
      "/fapi/v1/indexPriceKlines",
      %{pair: pair, interval: interval},
      api_key: Application.get_env(:binance, :futures_api_key),
      secret_key: Application.get_env(:binance, :futures_secret_key),
      base_url: Application.get_env(:binance, :futures_end_point)
    )
  end

  @doc """
  Continuous Contract Kline/Candlestick Data

  Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.continuous_contract_kline_candlestick_data("BTCUSDT", "PERPETUAL", "1h")
  """
  def continuous_contract_kline_candlestick_data(pair, contract_type, interval) do
    HTTPClient.get_binance_unsigned(
      "/fapi/v1/continuousKlines",
      %{pair: pair, contractType: contract_type, interval: interval},
      api_key: Application.get_env(:binance, :futures_api_key),
      secret_key: Application.get_env(:binance, :futures_secret_key),
      base_url: Application.get_env(:binance, :futures_end_point)
    )
  end

  @doc """
  Get Funding Rate History

  Mark Price and Funding Rate

  Weight: 1

  ## Examples

      BinanceFutures.get_funding_rate_history()
  """
  def get_funding_rate_history() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/fundingRate",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.FundingRateHistoryItem.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Mark Price

  Mark Price and Funding Rate

  Weight: 1

  ## Examples

      BinanceFutures.mark_price()
  """
  def mark_price() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/premiumIndex",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) -> {:ok, Enum.map(data, &Binance.Futures.MarkPrice.new/1)}
      {:ok, data} -> {:ok, Binance.Futures.MarkPrice.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Mark Price Kline/Candlestick Data

  Kline/candlestick bars for the mark price of a symbol. Klines are uniquely identified by their open time.

  ## Examples

      BinanceFutures.mark_price_kline_candlestick_data("BTCUSDT", "1h")
  """
  def mark_price_kline_candlestick_data(symbol, interval) do
    HTTPClient.get_binance_unsigned(
      "/fapi/v1/markPriceKlines",
      %{symbol: symbol, interval: interval},
      api_key: Application.get_env(:binance, :futures_api_key),
      secret_key: Application.get_env(:binance, :futures_secret_key),
      base_url: Application.get_env(:binance, :futures_end_point)
    )
  end

  @doc """
  Symbol Order Book Ticker

  Best price/qty on the order book for a symbol or symbols.

  ## Examples

      BinanceFutures.symbol_order_book_ticker()
  """
  def symbol_order_book_ticker() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/ticker/bookTicker",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) ->
        {:ok, Enum.map(data, &Binance.Futures.SymbolOrderBookTicker.new/1)}

      {:ok, data} ->
        {:ok, Binance.Futures.SymbolOrderBookTicker.new(data)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  24hr Ticker Price Change Statistics

  24 hour rolling window price change statistics.

  Careful when accessing this with no symbol.

  Weight:

  1 for a single symbol;

  40 when the symbol parameter is omitted

  ## Examples

      BinanceFutures.ticker_price_change_statistics()
  """
  def ticker_price_change_statistics() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/ticker/24hr",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) ->
        {:ok, Enum.map(data, &Binance.Futures.TickerPriceChangeStatistics.new/1)}

      {:ok, data} ->
        {:ok, Binance.Futures.TickerPriceChangeStatistics.new(data)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Symbol Price Ticker

  Latest price for a symbol or symbols.

  ## Examples

      BinanceFutures.symbol_price_ticker()
  """
  def symbol_price_ticker() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/ticker/price",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) ->
        {:ok, Enum.map(data, &Binance.Futures.SymbolPriceTicker.new/1)}

      {:ok, data} ->
        {:ok, Binance.Futures.SymbolPriceTicker.new(data)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Open Interest

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.open_interest("BTCUSDT")
  """
  def open_interest(symbol) do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/openInterest",
           %{symbol: symbol},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.OpenInterest.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Top Trader Long/Short Ratio (Accounts)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.top_trader_long_short_ratio_accounts("BTCUSDT", "1h")
  """
  def top_trader_long_short_ratio_accounts(symbol, period) do
    case HTTPClient.get_binance_unsigned(
           "/futures/data/topLongShortAccountRatio",
           %{symbol: symbol, period: period},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.LongShortRatio.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Open Interest Statistics

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.open_interest_statistics("BTCUSDT", "1h")
  """
  def open_interest_statistics(symbol, period) do
    case HTTPClient.get_binance_unsigned(
           "/futures/data/openInterestHist",
           %{symbol: symbol, period: period},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.OpenInterestStatistics.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Top Trader Long/Short Ratio (Positions)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.top_trader_long_short_ratio_positions("BTCUSDT", "1h")
  """
  def top_trader_long_short_ratio_positions(symbol, period) do
    case HTTPClient.get_binance_unsigned(
           "/futures/data/topLongShortPositionRatio",
           %{symbol: symbol, period: period},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.LongShortRatio.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Taker Buy/Sell Volume

  ## Examples

      BinanceFutures.taker_buy_sell_volume("BTCUSDT", "1h")
  """
  def taker_buy_sell_volume(symbol, period) do
    case HTTPClient.get_binance_unsigned(
           "/futures/data/takerlongshortRatio",
           %{symbol: symbol, period: period},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.TakerBuySellVolume.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Long/Short Ratio

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.long_short_ratio("BTCUSDT", "1h")
  """
  def long_short_ratio(symbol, period) do
    case HTTPClient.get_binance_unsigned(
           "/futures/data/globalLongShortAccountRatio",
           %{symbol: symbol, period: period},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.LongShortRatio.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Historical BLVT NAV Kline/Candlestick

  ## Examples

      BinanceFutures.historical_BLVT_NAV_kline_candlestick("BTCUSDT", "1h")
  """
  def historical_BLVT_NAV_kline_candlestick(symbol, interval) do
    HTTPClient.get_binance_unsigned(
      "/fapi/v1/lvtKlines",
      %{symbol: symbol, interval: interval},
      api_key: Application.get_env(:binance, :futures_api_key),
      secret_key: Application.get_env(:binance, :futures_secret_key),
      base_url: Application.get_env(:binance, :futures_end_point)
    )
  end

  @doc """
  Composite Index Symbol Information

  ## Examples

      BinanceFutures.composite_index_symbol_information()
  """
  def composite_index_symbol_information() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/indexInfo",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.CompositeIndexSymbolInfo.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Multi-Assets Mode Asset Index

  ## Examples

      BinanceFutures.multi_assets_mode_asset_index()
  """
  def multi_assets_mode_asset_index() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/assetIndex",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) ->
        {:ok, Enum.map(data, &Binance.Futures.MultiAssetsModeAssetIndex.new/1)}

      {:ok, data} ->
        {:ok, Binance.Futures.MultiAssetsModeAssetIndex.new(data)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Account information

  ## Examples

      BinanceFutures.account_information(1663181938993)
  """
  def account_information(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v2/account",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> Binance.Futures.Account.new(data)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get Income History

  ## Examples

      BinanceFutures.get_income_history(1663181938993)
  """
  def get_income_history(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/income",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.IncomeHistoryItem.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Position Information

  ## Examples

      BinanceFutures.position_information(1663181938993)
  """
  def position_information(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v2/positionRisk",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} when is_list(data) ->
        {:ok, Enum.map(data, &Binance.Futures.PositionInformation.new/1)}

      {:ok, data} ->
        {:ok, Binance.Futures.PositionInformation.new(data)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Account Trade List

  ## Examples

      BinanceFutures.account_trade_list("BTCUSDT", 1663181938993)
  """
  def account_trade_list(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/userTrades",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.AccountTrade.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Future Account Balance

  ## Examples

      BinanceFutures.future_account_balance(1663181938993)
  """
  def future_account_balance(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v2/balance",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.AccountBalance.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Notional and Leverage Brackets (USER_DATA)

  Get present open interest of a specific symbol.

  ## Examples

      BinanceFutures.notional_and_leverage_brackets(1663181938993)
  """
  def notional_and_leverage_brackets(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/leverageBracket",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.NotionalAndLeverageBracket.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Position ADL Quantile Estimation (USER_DATA)

  ## Examples

      BinanceFutures.position_ADL_quantile_estimation(1663181938993)
  """
  def position_ADL_quantile_estimation(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/adlQuantile",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.PositionAdlQuantileEstimation.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  User Commission Rate (USER_DATA)

  ## Examples

      BinanceFutures.user_commission_rate("BTCUSDT", 1663181938993)
  """
  def user_commission_rate(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/commissionRate",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> Binance.Futures.CommissionRate.new(data)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Change Multi-Assets Mode

  ## Examples

      BinanceFutures.change_multi_assets_mode("true", 1663181938993)
  """
  def change_multi_assets_mode(multi_assets_margin, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/multiAssetsMargin",
           %{multiAssetsMargin: multi_assets_margin, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get Current Multi-Assets Mode

  ## Examples

      BinanceFutures.get_current_multi_assets_mode(1663181938993)
  """
  def get_current_multi_assets_mode(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/multiAssetsMargin",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.MultiAssetsMargin.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  New Order (TRADE)

  https://binance-docs.github.io/apidocs/futures/en/#new-order-trade

  ## Examples

      BinanceFutures.new_order("BTCUSDT", "BUY", "LIMIT", 1, 10, 1663181938993)
  """
  def new_order(symbol, side, type, quantity, price, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/order",
           %{
             symbol: symbol,
             side: side,
             type: type,
             quantity: quantity,
             price: price,
             timestamp: timestamp
           },
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.OrderResponse.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Query Order

  ## Examples

      BinanceFutures.query_order("BTCUSDT", 1663181938993)
  """
  def query_order(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/order",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.Order.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Cancel Order

  ## Examples

      BinanceFutures.cancel_order("BTCUSDT", 1663181938993)
  """
  def cancel_order(symbol, timestamp \\ nil) do
    case HTTPClient.delete_binance(
           "/fapi/v1/order",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.OrderResponse.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Place Multiple Orders (TRADE)

  ## Examples

      BinanceFutures.place_multiple_orders([{type: "LIMIT", timeInForce: "GTC", symbol: "BTCUSDT", side: "BUY", price: "10001", quantity: "0.001"}], 1663181938993)
  """
  def place_multiple_orders(batch_orders, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/batchOrders",
           %{batchOrders: batch_orders, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.OrderResponse.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Cancel All Open Orders

  ## Examples

      BinanceFutures.cancel_all_open_orders("BTCUSDT", 1663181938993)
  """
  def cancel_all_open_orders(symbol, timestamp \\ nil) do
    case HTTPClient.delete_binance(
           "/fapi/v1/allOpenOrders",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Auto-Cancel All Open Orders (TRADE)

  ## Examples

      BinanceFutures.auto_cancel_all_open_orders("BTCUSDT", 1000, 1663181938993)
  """
  def auto_cancel_all_open_orders(symbol, countdown_time, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/countdownCancelAll",
           %{symbol: symbol, countdownTime: countdown_time, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.AutoCancelAllOpenOrdersResponse.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Current All Open Orders (USER_DATA)

  ## Examples

      BinanceFutures.current_all_open_orders(1663181938993)
  """
  def current_all_open_orders(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/openOrders",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.Order.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Cancel Multiple Orders (TRADE)

  ## Examples

      BinanceFutures.cancel_multiple_orders("BTCUSDT", ["my_id_1", "my_id_2"], 1663181938993)
  """
  def cancel_multiple_orders(symbol, orig_client_order_id_list, timestamp \\ nil) do
    case HTTPClient.delete_binance(
           "/fapi/v1/batchOrders",
           %{
             symbol: symbol,
             origClientOrderIdList: orig_client_order_id_list,
             timestamp: timestamp
           },
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok,
         Enum.map(data, fn order ->
           case order do
             %{"code" => code, "msg" => msg} -> %{code: code, msg: msg}
             order -> Binance.Futures.OrderResponse.new(order)
           end
         end)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Query Current Open Order (USER_DATA)

  ## Examples

      BinanceFutures.query_current_open_order("BTCUSDT", 1663181938993)
  """
  def query_current_open_order(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/openOrder",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.Order.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  User's Force Orders (USER_DATA)

  ## Examples

      BinanceFutures.user_force_orders(1663181938993)
  """
  def user_force_orders(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/forceOrders",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.Order.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  All Orders

  ## Examples

      BinanceFutures.all_orders("BTCUSDT", 1663181938993)
  """
  def all_orders(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/allOrders",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Enum.map(data, &Binance.Futures.Order.new/1)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Change Initial Leverage

  ## Examples

      BinanceFutures.change_initial_leverage("BTCUSDT", 10, 1663181938993)
  """
  def change_initial_leverage(symbol, leverage, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/leverage",
           %{symbol: symbol, leverage: leverage, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> Binance.Futures.ChangeInitialLeverageResponse.new(data)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Change Margin Type

  ## Examples

      BinanceFutures.change_margin_type("BTCUSDT", "ISOLATED", 1663181938993)
  """
  def change_margin_type(symbol, margin_type, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/marginType",
           %{symbol: symbol, marginType: margin_type, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Change Position Mode（TRADE）

  ## Examples

      BinanceFutures.change_position_mode("true", 1663181938993)
  """
  def change_position_mode(dual_side_position, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/positionSide/dual",
           %{dualSidePosition: dual_side_position, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get Postion Margin Change History

  ## Examples

      BinanceFutures.get_postion_margin_change_history("BTCUSDT", 1663181938993)
  """
  def get_postion_margin_change_history(symbol, timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/positionMargin/history",
           %{symbol: symbol, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} ->
        {:ok, Enum.map(data, &Binance.Futures.PositionMarginChangeHistoryItem.new/1)}

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Modify Isolated Position Margin

  ## Examples

      BinanceFutures.modify_isolated_position_margin("BTCUSDT", , "LIMIT", 1663181938993)
  """
  def modify_isolated_position_margin(symbol, amount, type, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/positionMargin",
           %{symbol: symbol, amount: amount, type: type, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Change Multi-Assets Mode (TRADE)

  ## Examples

      BinanceFutures.change_multi_assets_mode_TRADE("true", 1663181938993)
  """
  def change_multi_assets_mode_TRADE(multi_assets_margin, timestamp \\ nil) do
    case HTTPClient.post_binance(
           "/fapi/v1/multiAssetsMargin",
           %{multiAssetsMargin: multi_assets_margin, timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get Current Position Mode（USER_DATA）

  ## Examples

      BinanceFutures.get_current_position_mode(1663181938993)
  """
  def get_current_position_mode(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/positionSide/dual",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.CurrentPositionMode.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  User API Trading Quantitative Rules Indicators (USER_DATA)

  ## Examples

      BinanceFutures.user_API_trading_quantitative_rules_indicators(1663181938993)
  """
  def user_API_trading_quantitative_rules_indicators(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/apiTradingStatus",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.QuantitativeRulesIndicators.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Get Current Multi-Assets Mode (USER_DATA)

  ## Examples

      BinanceFutures.get_current_multi_assets_mode_USER_DATA(1663181938993)
  """
  def get_current_multi_assets_mode_USER_DATA(timestamp \\ nil) do
    case HTTPClient.get_binance(
           "/fapi/v1/multiAssetsMargin",
           %{timestamp: timestamp},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.MultiAssetsMargin.new(data)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Create New Listen Key

  ## Examples

      BinanceFutures.create_new_listen_key()
  """
  def create_new_listen_key() do
    case HTTPClient.post_binance_unsigned(
           "/fapi/v1/listenKey",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> Binance.DataStream.new(data)
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Renew Listen Key

  ## Examples

      BinanceFutures.renew_listen_key()
  """
  def renew_listen_key() do
    case HTTPClient.put_binance_unsigned(
           "/fapi/v1/listenKey",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Delete Listen Key

  ## Examples

      BinanceFutures.delete_listen_key()
  """
  def delete_listen_key() do
    case HTTPClient.delete_binance_unsigned(
           "/fapi/v1/listenKey",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Portfolio Margin Exchange Information

  ## Examples

      BinanceFutures.portfolio_margin_exchange_information()
  """
  def portfolio_margin_exchange_information() do
    case HTTPClient.get_binance_unsigned(
           "/fapi/v1/pmExchangeInfo",
           %{},
           api_key: Application.get_env(:binance, :futures_api_key),
           secret_key: Application.get_env(:binance, :futures_secret_key),
           base_url: Application.get_env(:binance, :futures_end_point)
         ) do
      {:ok, data} -> {:ok, Binance.Futures.PortfolioMarginExchangeInfo.new(data)}
      {:error, error} -> {:error, error}
    end
  end
end
