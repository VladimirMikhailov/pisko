defmodule Pisko.CommitsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    { :ok, [repo: "VladimirMikhailov/pg_dirtyread"] }
  end

  test "list/2", %{repo: repo} do
     use_cassette "commits#list" do
       assert Pisko.Commits.list(repo, [since: "2016-04-08"]) == []
     end
  end
end
