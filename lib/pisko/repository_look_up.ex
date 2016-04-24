defmodule Pisko.RepositoryLookUp do
  @moduledoc """
    Gathers information from github repository
    and passes it to logger in sync mode

    ## Examples

      iex> Pisko.RepositoryLookUp.lookup("VladimirMikhailov/pg_dirtyread")
  """

  import Pisko.Config, only: [since: 0, until: 0]

  @doc """
    Start retrieving and log commits for the repo

    ## Examples

      iex> Pisko.RepositoryLookUp.lookup(%{full_name => "VladimirMikhailov/pg_dirtyread"})
  """
  def lookup(%{"full_name" => repository}), do: lookup(repository)

  def lookup(repository) do
    Enum.each(commits(repository), &log/1)
  end

  defp log(commit) do
    Pisko.Logger.start_child(commit)
  end

  defp commits(repository) do
    Pisko.Commits.list(
      repository,
      [since: since, until: until]
    )
  end
end
