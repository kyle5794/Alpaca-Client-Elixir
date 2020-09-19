defmodule AlpacaClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :alpaca,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Alpaca.Supervisor, [env: Mix.env]},
      applications: applications(Mix.env)
    ]
  end

  defp applications(_), do: [:mojito]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.2"},
      {:mojito, "~> 0.7.1"},
    ]
  end
end
