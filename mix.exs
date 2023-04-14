defmodule RqrrEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :rqrr_ex,
      version: "0.1.2",
      compilers: Mix.compilers(),
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      name: "rqrr_ex",
      source_url: "https://github.com/denvera/rqrr_ex",
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
      {:rustler, "~> 0.27.0"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Simple binding to read QR codes using Rust rqrr crate. Uses Rustler for bindings."
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "rqrr_ex",
      licenses: ["MIT"],
      files:
        ~w(lib .formatter.exs mix.exs README* native/rqrr_ex_nif/Cargo* native/rqrr_ex_nif/src),
      links: %{"GitHub" => "https://github.com/denvera/rqrr_ex"}
    ]
  end
end
