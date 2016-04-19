defmodule Pisko.LoggerTest do
  use ExUnit.Case, async: true
  alias Pisko.Elastix.Commits, as: CommitsDocument

  setup do
    {:ok, _apps} = Application.ensure_all_started(:elastix)
    {:ok, %{commit: %{"sha" => "1", "info" => "info"}}}
  end

  test "log/1 saves commit in elasticsearch", %{commit: %{"sha" => sha }} = context do
    Pisko.Logger.log(context.commit)
    assert CommitsDocument.get(sha) == context.commit
  end
end
