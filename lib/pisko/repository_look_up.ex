defmodule Pisko.RepositioryLookUp do
  @moduledoc """
    Gathers information from github repository
    and passes it to logger in sync mode

    ## Examples

      iex> Pisko.RepositioryLookUp.lookup("VladimirMikhailov/pg_dirtyread")
  """

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
