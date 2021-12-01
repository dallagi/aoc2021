defmodule Aoc2021.Day1 do
  def part1(input) do
    input
    |> parse()
    |> sliding_windows(2)
    |> Enum.count(fn [prev, curr] -> curr > prev end)
  end

  def part2(input) do
    input
    |> parse()
    |> sliding_windows(3)
    |> Enum.map(&Enum.sum/1)
    |> sliding_windows(2)
    |> Enum.count(fn [prev, curr] -> curr > prev end)
  end

  defp parse(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  defp sliding_windows(enumerable, size), do: Enum.chunk_every(enumerable, size, 1, :discard)
end
