# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
import Config

config :binance,
  api_key: "",
  secret_key: "",
  end_point: "https://api.binance.com",
  futures_api_key: "",
  futures_secret_key: "",
  futures_end_point: "https://fapi.binance.com"

config :exvcr,
  filter_request_headers: [
    "X-MBX-APIKEY"
  ],
  filter_sensitive_data: [
    [pattern: "signature=[A-Z0-9]+", placeholder: "signature=***"]
  ]

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :binance, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:binance, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
