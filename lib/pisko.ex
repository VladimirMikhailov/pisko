defmodule Pisko do
  @moduledoc """
    The module aims to get latest github activity
    user activity and input it into adapter format
  """

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Task.Supervisor, [[name: Pisko.Log]]),
      worker(
        Pisko.ListLookUpTask,
        [Pisko.OrganizationsLookUp, organizations],
        restart: :temporary
      )
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp organizations do
    Application.get_env(:pisko, :organizations)
  end
end
