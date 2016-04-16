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
      supervisor(Task.Supervisor, [[name: Pisko.Log]]),
      worker(
        Task,
        [Pisko.OrganizationsLookUp, :start, [organizations]],
        restart: :temporary
      )
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp organizations do
    Application.get_env(:pisko, :organizations)
  end
end
