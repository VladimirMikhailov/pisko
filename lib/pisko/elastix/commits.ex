defmodule Pisko.Elastix.Commits do
  @moduledoc """
    Provides interface to access commit documents
    from ElasticSearch

    ## Examples

      iex> Pisko.Elastix.Commits.index(%{"sha" => "hello", "info" => "info"})
      iex> Pisko.Elastix.Commits.get("hello")
      %{"sha" => "hello", "info" => "info"}

  """

  import Pisko

  @index_name "pisko_metr"
  @doc_type "commits"

  @doc "Save commit into ElasticSearch index"
  def index(%{"sha" => sha} = commit) do
    Elastix.Document.index(get_env(:elastic), @index_name, @doc_type, sha, commit)
  end

  @doc "Get commit from ElasticSearch index by commit sha"
  def get(sha) do
    body = Elastix.Document.get(get_env(:elastic), @index_name, @doc_type, sha).body
    {:ok, value} = Map.fetch(body, "_source")

    value
  end
end
