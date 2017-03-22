defmodule IslandsEngine.Island do
  alias IslandsEngine.Island
  alias IslandsEngine.Coordinate

  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  def replace_coordinates(island, new_coordinates)
  when is_list new_coordinates do
    Agent.update(island, fn _state -> new_coordinates end)
  end

  def forested?(island) do
    Agent.get(island, fn state -> state end)
    |> Enum.all?(fn coord -> Coordinate.hit?(coord) == true end)
  end

  def to_string(island) do
    island_string =
      Agent.get(island, fn state -> state end)
      |> Enum.reduce("", fn
        coord, acc -> "#{acc}, #{Coordinate.to_string(coord)}"
      end)
    "[" <> String.replace_leading(island_string, ", ", "") <> "]"
  end
end
