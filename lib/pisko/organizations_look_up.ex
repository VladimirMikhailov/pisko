defmodule Pisko.OrganizationsLookUp do
  @moduledoc """
    Wrap arround organizations collection to start
    look up commits from organization repositories
    in non-blocking manner

    ## Examples

      iex> Pisko.OrganizationLookUp.lookup("piskopie")
  """

  alias Pisko.ListLookUpTask, as: Task

  def lookup(organization) do
    Task.start_link(Pisko.RepositoryLookUp, repositories(organization))
  end

  defp repositories(organization) do
    Pisko.Repositories.items(organization, "2016-03-12")
  end
end
