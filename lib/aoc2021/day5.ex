defmodule Aoc2021.Day5 do
  def part1(input) do
    input
    |> parse
    |> build_diagram()
    |> Enum.count(fn {_coord, count} -> count > 1 end)
  end

  def part2(input) do
    nil
  end

  defp build_diagram(lines) do
    # %{ {x, y} => 1 }
    lines
    |> Enum.flat_map(&touched_points/1)
    |> Enum.reduce(
      %{},
      fn line, diagram -> Map.update(diagram, line, 1, &(&1 + 1)) end
    )
  end

  defp touched_points({{x, from_y}, {x, to_y}}), do: Enum.map(from_y..to_y, &({x, &1}))
  defp touched_points({{from_x, y}, {to_x, y}}), do: Enum.map(from_x..to_x, &({&1, y}))
  defp touched_points(_), do: []

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split(~r"(,| \-> )", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn [from_x, from_y, to_x, to_y] -> {{from_x, from_y}, {to_x, to_y}} end)
  end
end
