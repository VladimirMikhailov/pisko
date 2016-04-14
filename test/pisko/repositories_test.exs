defmodule Pisko.RepositoriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup context do
    use_cassette "#{context.cassette}_repositories#list" do
      repositories = Pisko.Repositories.list(
        "piskopie",
        context.since
      )

      { :ok, [repositories: repositories] }
    end
  end

  @tag since: "2016-03-29", cassette: "pisko"
  test "list/2 when it is any available repo", %{repositories: repositories} do
    assert repositories["total_count"] == 1
  end

  @tag since: "2030-03-29", cassette: "empty"
  test "list/2 when it is no repo matching searching", %{repositories: repositories} do
    assert repositories["total_count"] == 0
  end
end
