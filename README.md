# RqrrEx

[![Hex.pm Version](https://img.shields.io/hexpm/v/rqrr_ex.svg?style=flat-square)](https://hex.pm/packages/rqrr_ex)

Simple binding to allow using [rqrr](https://docs.rs/rqrr/0.3.0/rqrr/index.html) from Elixir. Uses Rustler for bindings.

## Requirements
Working Rust toolchain.

## Installation

Add `rqrr_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rqrr_ex, "~> 0.1.0-rc.0"}
  ]
end
```

## Examples

Detect and decode QR codes from a file supported by the Rust [image](https://crates.io/crates/image) crate.

```elixir
  RqrrEx.detect_qr_codes(File.read!("./test.png"))
  {:ok,
  [
    ok: {%{
        __struct__: Rqrr.Metadata,
        bounds: [{474, 674}, {569, 674}, {569, 770}, {474, 770}],
        ecc_level: 1,
        mask: 2,
        version: 41
      },
      "The QR Code Content!"}
  ]}

```

Documentation can be found at [https://hexdocs.pm/rqrr_ex](https://hexdocs.pm/rqrr_ex).

