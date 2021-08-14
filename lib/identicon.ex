defmodule Identicon do
  require Logger

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%{hex: hex} = _image) do
    hex
    |> Enum.chunk_every(3, 3, :discard)
    # |> Enum.map(fn [a, b, c] -> [a, b, c, b, a] end)
    # |> Enum.map(&mirror_row/1)
    |> Enum.map(&mirror_row(&1))
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end

  def pick_color(%{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
