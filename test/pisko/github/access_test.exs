defmodule Pisko.Github.AccessTest do
  use ExUnit.Case
  doctest Pisko.Github.Access

  alias Pisko.Github.Access, as: Access

  setup do
    Application.put_env(:pisko, :access_token, "u1d1")
    Access.start_link

    {:ok, %{}}
  end

  test "update/1 updates token reset info" do
    reset = :erlang.system_time + :timer.minutes(5)

    Access.update(reset)
    Access.token

    assert_receive({:wait_until, reset}, 50)
  end
end
