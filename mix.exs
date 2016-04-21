defmodule Pisko.Mixfile do
  use Mix.Project

  def project do
    [app: :pisko,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :tentacat, :elastix],
    mod: {Pisko, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:tentacat, "~> 0.2"},
      {:elastix, "~> 0.1.1"},
      {:good_times, "~> 1.1"},
      {:elixometer, github: "pinterest/elixometer"},
      {:dogma, "~> 0.1", only: :dev},
      {:exvcr, "~> 0.6", only: :test}
    ]
  end
end
