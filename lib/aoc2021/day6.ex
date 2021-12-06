defmodule Aoc2021.Day6 do
  def part1(input) do
    input
    |> parse
    |> lanternfishes_after_days(80)
  end

  def part2(input) do
    input
    |> parse
    |> lanternfishes_after_days(256)
  end

  defp lanternfishes_after_days(lanternfishes, 0), do: lanternfishes |> Map.values() |> Enum.sum()

  defp lanternfishes_after_days(lanternfishes, days) do
    lanternfishes_to_reset = Map.get(lanternfishes, 0, 0)

    new_lanternfishes =
      lanternfishes
      |> Enum.map(fn
        {0, num} -> {8, num}
        {age, num} -> {age - 1, num}
      end)
      |> Enum.into(%{})
      |> Map.update(6, lanternfishes_to_reset, &(&1 + lanternfishes_to_reset))

    lanternfishes_after_days(new_lanternfishes, days - 1)
  end

  defp parse(input) do
    input
    |> String.split(",")
    |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))
    |> Enum.frequencies()
  end
end
