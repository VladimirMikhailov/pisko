defmodule Pisko.ListLookUpTask do
  @moduledoc """
    Starts a new proc for each list item
    and awaiting for exit from all started
    processes

    ## Example

    iex> Pisko.ListLookUpTask.start_link(module, list)

  """

  def start_link(module, list) do
    Task.start_link(__MODULE__, :start, [module, list])
  end

  def start(module, list) do
    Enum.each(list, fn(item) -> lookup(module, item) end)
    await_list(length(list))
  end

  defp lookup(module, item) do
    {:ok, pid} = Task.start_link(module, :lookup, [item])
    Process.register(pid, module.ref(item))
  end

  defp await_list(0), do: 0
  defp await_list(length) do
    receive do
      {:EXIT, _from, :normal} -> await_list(length - 1)
    end
  end
end
