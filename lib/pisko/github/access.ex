defmodule Pisko.Github.Access do
  @moduledoc """
    The module provides an access to token
    and hides internal token gathering logic.

    In order to hide private date all tokens
    should be passed through `TOKEN` environment
    variable

    ## Examples
      iex> Application.put_env(:pisko, :access_token, "u1d1")
      ...> Pisko.Github.Access.token
      "u1d1"
  """

  def token do
    Pisko.Config.get_env(:access_token)
  end
end
