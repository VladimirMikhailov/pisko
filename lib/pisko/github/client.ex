defmodule Pisko.Github.Client do
  @moduledoc """
    Single access point to github api
  """

  def list(url, params) do
    apply(Tentacat, :get, [url, client | params])
  end

  def search(params) do
    Tentacat.Search.repositories(params, client)
  end

  def get(url) do
    Process.flag(:trap_exit, true)
    parent = self

    spawn_link(fn -> send(parent, {:response, Tentacat.get(url, client)}) end)

    receive do
      {:EXIT, _from, {:wait_until, reset}} -> :timer.sleep(reset - :erlang.system_time)
      {:response, response} -> response
    end
  end

  defp client do
    Tentacat.Client.new(%{access_token: Pisko.Github.Access.token})
  end
end
