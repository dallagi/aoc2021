defmodule Aoc2021.Day7 do
  def part1(input) do
    positions = parse(input)
    {min_pos, max_pos} = Enum.min_max(positions)

    min_pos..max_pos
    |> Enum.map(fn pos -> positions |> Enum.map(&abs(&1 - pos)) |> Enum.sum() end)
    |> Enum.min()
  end

  def part2(input) do
    positions = parse(input)
    {min_pos, max_pos} = Enum.min_max(positions)

    min_pos..max_pos
    |> Enum.map(fn pos -> positions |> Enum.map(&aligning_cost(&1, pos)) |> Enum.sum() end)
    |> Enum.min()
  end

  defp aligning_cost(from, to) do
    distance = abs(to - from)
    round(distance * (distance + 1) / 2)
  end

  defp parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
  end
end
