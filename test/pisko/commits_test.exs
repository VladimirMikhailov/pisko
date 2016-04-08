defmodule PiskoTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    commits = Pisko.Commits.list("VladimirMikhailov/pg_dirtyread", [since: "2016-03-29"])
    { :ok, [commits: commits] }
  end

  test "list/2", %{commits: commits} do
     use_cassette "commits#list" do
       assert length(commits) == 4
     end
  end

  test "list/2 full info", %{commits: commits} do
     use_cassette "commits#list" do
       commit = commits |> List.first
       assert(Map.has_key?(commit, "stats"))
     end
  end
end
