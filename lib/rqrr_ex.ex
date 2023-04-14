defmodule RqrrEx.Metadata do
@moduledoc """
  Metadata of a QR code
  """
  defstruct version: 1,
            modules: 21,
            ecc_level: 0,
            mask: 0,
            bounds: []

  @typedoc """
  Barcode metadata
  * `:version`: Version of the QR Code
  * `:modules`: The number of modules of the QR Code
  * `:ecc_level`: Error correction level of the QR Code
  * `:bounds`: The four boundary points of the QR Code
  """
  @type t :: %__MODULE__{
          version: pos_integer(),
          modules: pos_integer(),
          ecc_level: non_neg_integer(),
          mask: non_neg_integer(),
          bounds: list({integer(), integer()})
        }
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
            modules: 41
            version: 6
          },
          "The contents of the QR code!"}
      ]}

  """
  @spec detect_qr_codes(binary()) ::
          {:ok, [{:ok, {RqrrEx.Metadata.t(), String.t()}} | {:error, String.t()}]}
          | {:error, String.t()}
  def detect_qr_codes(_image_bytes), do: :erlang.nif_error(:nif_not_loaded)
end
