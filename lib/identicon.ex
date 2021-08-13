defmodule Identicon do
  require Logger

  def main(input) do
    input
    |> hash_input
    |> pick_color
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
