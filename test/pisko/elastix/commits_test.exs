defmodule Pisko.Elastix.CommitsTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, _apps} = Application.ensure_all_started(:elastix)
    :ok
  end

  doctest Pisko.Elastix.Commits
end
