defmodule RqrrEx.Metadata do
  defstruct [
    version: 0,
    ecc_level: 0,
    mask: 0,
    bounds: [],
  ]
end

defmodule RqrrEx do
   @moduledoc """
  Call out to nif to detect barcodes using Rust rqrr crate.
  """
  use Rustler, otp_app: :rqrr_ex, crate: :rqrr_ex_nif

  @doc """
  Detect a QR code in the image provided as a binary()

  Returns `[{:ok, {%RqrrEx.Metadata{}, String.t()}} | {:error, String.t()}]`.

  ## Examples

      iex> RqrrEx.detect_qr_codes(File.read!("./test.png"))
      {:ok,
      [
        ok: {%{
            __struct__: Rqrr.Metadata,
            bounds: [{474, 674}, {569, 674}, {569, 770}, {474, 770}],
            ecc_level: 1,
            mask: 2,
            version: 41
          },
          "The contents of the QR code!"}
      ]}

  """
  @spec detect_qr_codes(binary()) :: [{:ok, {%RqrrEx.Metadata{}, String.t()}} | {:error, String.t()}]
  def detect_qr_codes(_image_bytes), do: :erlang.nif_error(:nif_not_loaded)
end
