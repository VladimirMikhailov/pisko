defmodule Pisko do
  @moduledoc """
    The module aims to get latest github activity
    user activity and input it into adapter format
  """

  use Application
  import Pisko.Config, only: [get_env: 1]

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
    get_env(:organizations)
  end
end
