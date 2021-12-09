defmodule Aoc2021.Day9 do
  def part1(input) do
    low_points = input |> parse() |> low_points()
    length(low_points) + Enum.sum(low_points)
  end

  def part2(input) do
    nil
  end

  defp low_points(locations) do
    for {row, y} <- Enum.with_index(locations),
        {height, x} <- Enum.with_index(row),
        low_point?(locations, {x, y}, height) do
      height
    end
  end

  defp low_point?(locations, {x, y}, height) do
    adjacent_deltas = [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]

    adjacent_deltas
    |> Enum.map(fn {delta_x, delta_y} ->
      adjacent_point_x = x + delta_x
      adjacent_point_y = y + delta_y

      height_at(locations, {adjacent_point_x, adjacent_point_y})
    end)
    |> Enum.reject(&(&1 == nil))
    |> Enum.all?(&(&1 > height))
  end

  defp height_at(_, {x, y}) when x < 0 or y < 0, do: nil
  defp height_at(locations, {x, y})  do
      locations
      |> Enum.at(y, [])
      |> Enum.at(x)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)
    end)
  end
end
