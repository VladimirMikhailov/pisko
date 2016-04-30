defmodule Pisko.Github.Client do
  @moduledoc """
    Single access point to github api
  """

  def list(args) do
    apply(Tentacat.get, [client | args])
  end

  def search(params) do
    Tentacat.Search.repositories(params, client)
  end

  def get(args) do
    apply(Tentacat.get, [args | client])
  end

  defp client do
    Tentacat.Client.new(%{access_token: Pisko.Github.Access.token})
  end
end
