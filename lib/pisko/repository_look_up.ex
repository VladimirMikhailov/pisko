defmodule Pisko.RepositoryLookUp do
  @moduledoc """
    Gathers information from github repository
    and passes it to logger in sync mode

    ## Examples

      iex> Pisko.RepositoryLookUp.lookup("VladimirMikhailov/pg_dirtyread")
  """

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
      [since: month_ago]
    )
  end

  defp month_ago do
    import GoodTimes

    {{year, month, day}, _} = months_ago(1)

    "#{year}-#{month}-#{day}"
  end
end
