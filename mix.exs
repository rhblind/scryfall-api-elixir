defmodule Scryfall.MixProject do
  use Mix.Project

  def project do
    [
      app: :scryfall,
      version: "0.1.0",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bypass, "~> 1.0", only: :test},
      {:credo, "~> 1.1", only: [:test, :dev]},
      {:cachex, "~> 3.2"},
      {:ex_string_util, "~> 0.1.0"},
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
