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
    Tentacat.get(url, client)
  end

  defp client do
    Tentacat.Client.new(%{access_token: Pisko.Github.Access.token})
  end
end
