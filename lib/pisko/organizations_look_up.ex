defmodule Pisko.OrganizationsLookUp do
  @moduledoc """
    Wrap arround organizations collection to start
    look up commits from organization repositories
    in non-blocking manner

    ## Examples

      iex> Pisko.OrganizationLookUp.start("piskopie")
  """

  def start(organizations) do
    Enum.each(organizations, &lookup_repositories/1)
  end

  defp lookup_repositories(organization) do
    Pisko.Repositories.list(organization, "2016-03-12") |> Enum.each(&lookup_repository/1)
  end

  defp lookup_repository(%{"full_name" => repository}) do
    Task.start_link(Pisko.RepositoryLookUp, :start, [repository])
  end
end
