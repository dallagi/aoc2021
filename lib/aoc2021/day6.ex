defmodule Aoc2021.Day6 do
  def part1(input) do
    input
    |> parse
    |> lanternfishes_after_days(80)
    |> Enum.count()
  end

  defp lanternfishes_after_days(ages, 0), do: ages

  defp lanternfishes_after_days(ages, days) do
    # I know this is inefficient, but it will work for now
    new_ages = ages_after_one_day(ages) ++ generated_lanternfishes(ages)
    lanternfishes_after_days(new_ages, days - 1)
  end

  defp ages_after_one_day(starting_ages) do
    Enum.map(starting_ages, fn
      0 -> 6
      age -> age - 1
    end)
  end

  defp generated_lanternfishes(ages) do
    for age <- ages, age == 0, do: 8
  end

  def part2(input) do
    input
    |> parse
    |> lanternfishes_after_days(256)
    |> Enum.count()
  end

  defp parse(input),
    do: input |> String.split(",") |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
end
