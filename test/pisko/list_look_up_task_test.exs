defmodule Pisko.ListLookUpTaskTest do
  use ExUnit.Case

  defmodule ListLookUpFakeConsumer do
    def lookup(item) do
      Process.register(self, String.to_atom("look_up_fake_#{item}"))
      receive do _other -> nil end
    end
  end

  setup context do
    {:ok, pid} = Pisko.ListLookUpTask.start_link(ListLookUpFakeConsumer, context.list)
    Process.monitor(pid)

    context.list |> Enum.each(fn(item) ->
      waitforstart(String.to_atom("look_up_fake_#{item}"))
    end)
  end

  @tag list: ["org0", "org1"]
  test "start_link/1 waits all processes to complete" do
    exit_process("org1")

    refute_receive({:DOWN, _ref, :process, _pid, :normal}, 50)
  end

  @tag list: ["org2"]
  test "start_link/1 exits when all process completed" do
    exit_process("org2")

    assert_receive({:DOWN, _ref, :process, _pid, :normal}, 50)
  end

  def exit_process(item) do
    reference = String.to_atom("look_up_fake_#{item}")

    send(reference, "goodbye")
    waitforexit(reference)
  end

  def waitforexit(refence), do: waitforexit(Process.whereis(refence), refence)
  def waitforexit(process, _refence) when is_nil(process), do: nil
  def waitforexit(_process, refence), do: waitforexit(refence)

  def waitforstart(refence), do: waitforstart(Process.whereis(refence), refence)
  def waitforstart(process, refence) when is_nil(process), do: waitforstart(refence)
  def waitforstart(_process, _refence), do: nil
end
