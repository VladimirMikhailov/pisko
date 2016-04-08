defmodule Pisko.Commits do
  @moduledoc """
    Retrieve github commits wrapper
  """

  import Tentacat, only: [get: 4]

  @client Tentacat.Client.new(
    %{access_token: Application.get_env(:pisko, :access_token)}
  )

  def list(repo, params \\ []) do
    get(
      "repos/#{repo}/commits",
      @client,
      params,
      [pagination: :stream]
    )
  end
end
