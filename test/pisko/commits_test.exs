defmodule Pisko.CommitsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    use_cassette "commits#list" do
      commits = Pisko.Commits.list(
        "VladimirMikhailov/pg_dirtyread",
        [since: "2016-03-29"]
      )

      { :ok, [commits: commits] }
    end
  end

  test "list/2", %{commits: commits} do
    assert length(commits) == 4
  end

  test "list/2 full info", %{commits: commits} do
     commits
      |> List.first
      |> Map.has_key?("stats")
      |> assert
  end
end
