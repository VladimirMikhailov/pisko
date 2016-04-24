defmodule Pisko.Config do
  @moduledoc """
    A wrapper around Pisko app config

    ## Examples

      Pisko.Config.since
      Pisko.Config.until

  """

  @doc """
    Get Pisko app specific configs

    ## Examples

      iex> Application.put_env(:pisko, :my_app_name, "yoyoyo")
      ...> Pisko.Config.get_env(:my_app_name)
      "yoyoyo"
  """
  def get_env(key) do
    Application.get_env(:pisko, key)
  end

  @doc "Returns a since value from timeframe config"
  def since do
    [since, _until] = get_env(:timeframe)
    since
  end

  @doc "Returns a until value from timeframe config"
  def until do
    [_since, until] = get_env(:timeframe)
    until
  end
end
