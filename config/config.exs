# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :pisko, key: :value
#
# And access this configuration in your application as:
#
#     Pisko.Config.get_env(:key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
config(:pisko, elastic: System.get_env("ELASTIC_URL") || "http://127.0.0.1:9200")
config(:pisko, organizations: String.split((System.get_env("ORGANIZATIONS") || "piskopie"), ","))
config(:pisko, timeframe: String.split((System.get_env("TIMEFRAME") || "2016-03-12,2016-04-12"), ","))

import_config "#{Mix.env}.private.exs"
import_config "exometer.exs"
