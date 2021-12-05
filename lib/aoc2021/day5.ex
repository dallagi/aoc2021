defmodule Aoc2021.Day5 do
  def part1(input) do
    input
    |> parse
    |> build_diagram(false)
    |> Enum.count(fn {_coord, count} -> count > 1 end)
  end

  def part2(input) do
    input
    |> parse
    |> build_diagram(true)
    |> Enum.count(fn {_coord, count} -> count > 1 end)
  end

  defp build_diagram(lines, include_diagonals?) do
    touched_points = Enum.flat_map(lines, &touched_points(&1, include_diagonals?))

    Enum.reduce(touched_points, %{}, fn line, diagram ->
      Map.update(diagram, line, 1, &(&1 + 1))
    end)
  end

  def touched_points({{x, from_y}, {x, to_y}}, _), do: Enum.map(from_y..to_y, &{x, &1})
  def touched_points({{from_x, y}, {to_x, y}}, _), do: Enum.map(from_x..to_x, &{&1, y})

  def touched_points({{from_x, from_y}, {to_x, to_y}}, true),
    do: Enum.zip(from_x..to_x, from_y..to_y)

  def touched_points(_, false), do: []

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split(~r"(,| \-> )", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn [from_x, from_y, to_x, to_y] -> {{from_x, from_y}, {to_x, to_y}} end)
  end
end
