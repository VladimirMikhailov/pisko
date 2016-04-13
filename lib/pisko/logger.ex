defmodule Pisko.Logger do
  @moduledoc """
    Saves commits into elasticsearch

    ## Examples
      iex> Pisko.Logger.log(commit)


    If you like to run the process in non-blocking
    manner you could use start_child wrap function
    which involved to perform log as Task process

      iex> Pisko.start_child(commit)
  """

  alias Pisko.Elastix.Commits, as: CommitsDocument

  def log(commit) do
    CommitsDocument.index(commit)
  end

  @doc "Wrapper for starting supervisioning child log process"
  def start_child(commit) do
    Task.Supervisor.start_child(Pisko.Log, fn -> Pisko.Logger.log(commit) end)
  end
end
