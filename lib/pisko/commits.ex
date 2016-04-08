defmodule Pisko.Commits do
  @moduledoc """
    Retrieve github commits wrapper
  """

  import Tentacat, only: [get: 4, get: 2]

  @client Tentacat.Client.new(
    %{access_token: Application.get_env(:pisko, :access_token)}
  )

  def list(repo, params) do
    get(
      "repos/#{repo}/commits",
      @client,
      params,
      [pagination: :stream]
    ) |> find_all(repo)
  end

  def find(repo, %{"sha" => sha} = _commit) do
    get("repos/#{repo}/commits/#{sha}", @client)
  end

  defp find_all(stream, repo) do
    Enum.map(stream, fn(commit) -> find(repo, commit) end)
  end
end
