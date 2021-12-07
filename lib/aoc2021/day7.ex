defmodule Aoc2021.Day7 do
  def part1(input) do
    numbers = parse(input)

    numbers
    |> Enum.map(fn num -> numbers |> Enum.map(&abs(&1 - num)) |> Enum.sum() end)
    |> Enum.min()
  end

  def part2(input) do
    nil
  end

  defp parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
  end
end
