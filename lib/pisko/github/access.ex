defmodule Pisko.Github.Access do
  @moduledoc """
    The module provides an access to token
    and hides internal token gathering logic.

    In order to hide private date all tokens
    should be passed through `TOKEN` environment
    variable

    ## Examples
      iex> Pisko.Github.Access.start_link
      ...> Agent.update(Pisko.Github.Access, fn (token) -> %{ token: "u1d1", reset: 0 } end)
      ...> Pisko.Github.Access.token
      "u1d1"
  """

  def start_link do
    Agent.start_link(fn -> init end, name: __MODULE__)
  end

  @doc "Updates token's reset time info"
  def update(reset) do
    Agent.update(__MODULE__, fn (token) -> %{ token | reset: reset } end)
  end

  @doc "Returns token if reset time is in the past"
  def token do
    Agent.get(__MODULE__, &(&1)) |> token(:erlang.system_time)
  end

  defp token(%{reset: reset}, system_time) when reset > system_time do
    Process.exit(self(), {:wait_until, reset})
  end

  defp token(%{token: token}, _system_time), do: token

  defp init do
    %{token: Pisko.Config.get_env(:access_token), reset: 0}
  end
end
