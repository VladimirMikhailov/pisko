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
    get_env(:organizations)
  end

  @doc """
    Get Pisko app specific configs

    ## Examples

      iex> Application.put_env(:pisko, :my_app_name, "yoyoyo")
      ...> Pisko.get_env(:my_app_name)
      "yoyoyo"
  """
  def get_env(key) do
    Application.get_env(:pisko, key)
  end
end
