defmodule Pisko.Github.ClientTest do
  use ExUnit.Case, async: false

  alias Pisko.Github.Access, as: Access
  alias Pisko.Github.Client, as: Client

  import Mock

  setup do
    Access.start_link
    {:ok, %{}}
  end

  test_with_mock "get/1 and waits for a wait_until",
    Tentacat, [], [get: fn (_url, _client) -> "completed" end] do
    time = :erlang.system_time + :timer.minutes(10)
    Access.update(time)

    task = Task.async(fn -> Client.get("repos/piskopie/pisko/commits/65311216e9ba3d9643c7eaacd97406f24e25d88d") end)
    refute Task.yield(task, 50) === {:ok, "completed"}
  end
end
