defmodule Pisko.Github.ClientTest do
  use ExUnit.Case, async: true

  alias Pisko.Github.Access, as: Access
  alias Pisko.Github.Client, as: Client

  setup do
    Application.ensure_all_started(:tentacat)
    Access.start_link
    {:ok, %{}}
  end

  test "get/1 and receive wait_until" do
    time = :erlang.system_time + :timer.seconds(10)
    #Access.update(time)
    Client.get("repos/piskopie/pisko/commits/65311216e9ba3d9643c7eaacd97406f24e25d88d")
  end
end
