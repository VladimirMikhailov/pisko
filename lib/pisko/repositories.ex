defmodule Pisko.Repositories do
  @moduledoc """
    Search github org repositories.
    https://developer.github.com/v3/search/#search-repositories

    ## Examples

      iex> Pisko.Repositories.list("awesome", "2016-03-14")
  """

  @client Tentacat.Client.new(
    %{access_token: Application.get_env(:pisko, :access_token)}
  )

  def list(owner, since) do
    Tentacat.Search.repositories(
      %{q: "user:#{owner} pushed:>=#{since}"},
      @client
    )
  end
end
