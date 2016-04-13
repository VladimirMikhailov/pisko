defmodule Pisko do
  @moduledoc """
    The module aims to get latest github activity
    user activity and input it into adapter format
  """

  use Application

  @repository "VladimirMikhailov/pg_dirtyread"

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: Pisko.Log]])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
