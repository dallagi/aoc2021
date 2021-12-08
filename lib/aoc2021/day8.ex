defmodule Aoc2021.Day8 do
  def part1(input) do
    input
    |> parse
    |> Enum.map(fn {_patterns, output} ->
      output
      |> Enum.filter(&(String.length(&1) in [2, 3, 4, 7]))
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  def part2(input) do
    nil
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [patterns, output] = String.split(line, " | ", parts: 2, trim: true)
      {String.split(patterns, " ", trim: true), String.split(output, " ", trim: true)}
    end)
  end
end
