defmodule Pisko.Commits do
  @moduledoc """
    Retrieve github commits.
    Responds with a full commit information
    including stats from single commit api end point
    (https://developer.github.com/v3/repos/commits/#get-a-single-commit)

    ## Examples

      iex> Pisko.Commits.list("awesome/repo", [since: "2016-03-14"])
  """

  import Pisko.Github.Client, only: [get: 1]

  def list(repo, params) do
    "repos/#{repo}/commits"
    |> Pisko.Github.Client.list([params, [pagination: :stream]])
    |> find_all(repo)
  end

  def find(repo, %{"sha" => sha} = _commit) do
    get("repos/#{repo}/commits/#{sha}")
  end

  defp find_all(stream, repo) do
    Enum.map(stream, fn(commit) -> find(repo, commit) end)
  end
end
