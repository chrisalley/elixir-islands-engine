defmodule IslandsEngine.Coordinate do
  defstruct in_island: :none, guessed?: false

  alias IslandsEngine.Coordinate

  def start_link() do
    Agent.start_link(fn -> %Coordinate{} end)
  end

  def guessed?(coordinate) do
    Agent.get(coordinate, fn state -> state.guessed? end)
  end

  def island(coordinate) do
    Agent.get(coordinate, fn state -> state.in_island end)
  end

  def in_island?(coordinate) do
    case Agent.get(coordinate, fn state -> state.in_island end) do
      :none -> false
      _ -> true
    end
  end

  def hit?(coordinate) do
    Coordinate.in_island?(coordinate) && Coordinate.guessed?(coordinate)
  end

  def guess(coordinate) do
    Agent.update(coordinate, fn state -> Map.put(state, :guessed?, true) end)
  end

  def set_in_island(coordinate, value) when is_atom value do
    Agent.update(coordinate, fn state -> Map.put(state, :in_island, value) end)
  end

  def to_string(coordinate) do
    "(in_island:#{island(coordinate)}, guessed:#{guessed?(coordinate)})"
  end
end
