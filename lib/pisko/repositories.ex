defmodule Pisko.Repositories do
  @moduledoc """
    Search github org repositories.
    https://developer.github.com/v3/search/#search-repositories

    ## Examples

      iex> Pisko.Repositories.list("awesome", "2016-03-14")
  """

  def list(owner, since) do
    Pisko.Github.Client.search(q: "user:#{owner} pushed:>=#{since}")
  end

  @doc "Returns items attribute from repositories list response"
  def items(owner, since) do
    response_items(list(owner, since))
  end

  defp response_items(%{"incomplete_results" => _, "items" => items}), do: items
  defp response_items(list) do
    Enum.flat_map(list, fn(response) -> Map.get(response, "items") end)
  end
end
