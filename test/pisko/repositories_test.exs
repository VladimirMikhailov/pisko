defmodule Pisko.RepositoriesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup context do
    use_cassette "#{context.cassette}_repositories#list" do
      results = apply(
        Pisko.Repositories,
        context.described_fn,
        ["piskopie", context.since]
      )

      { :ok, [results: results] }
    end
  end

  @tag since: "2016-03-29", cassette: "pisko", described_fn: :list
  test "list/2 when it is any available repo", %{results: results} do
    assert results["total_count"] == 1
  end

  @tag since: "2030-03-29", cassette: "empty", described_fn: :list
  test "list/2 when it is no repo matching searching", %{results: results} do
    assert results["total_count"] == 0
  end

  @tag since: "2016-03-29", cassette: "pisko", described_fn: :items
  test "items/2 when it is any available repo", %{results: results} do
    Enum.each(results, fn(item) -> assert(item["full_name"] == "piskopie/pisko") end)
  end
end
