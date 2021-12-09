defmodule Aoc2021.Day9 do
  def part1(input) do
    locations = parse(input)
    low_points = locations |> low_points() |> Enum.map(&height_at(locations, &1))
    length(low_points) + Enum.sum(low_points)
  end

  def part2(input) do
    locations = parse(input)

    locations
    |> low_points()
    |> Enum.map(&basin(&1, locations))
    |> Enum.map(&length/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(&Kernel.*/2)
  end

  defp low_points(locations) do
    for {row, y} <- Enum.with_index(locations),
        {height, x} <- Enum.with_index(row),
        low_point?(locations, {x, y}, height) do
      {x, y}
    end
  end

  defp low_point?(locations, {x, y}, height) do
    {x, y}
    |> adjacent_coordinates()
    |> Enum.map(fn {adj_x, adj_y} -> height_at(locations, {adj_x, adj_y}) end)
    |> Enum.reject(&(&1 == nil))
    |> Enum.all?(&(&1 > height))
  end

  defp basin({x, y} = _low_point, locations) do
    MapSet.to_list(basin({x, y}, locations, MapSet.new()))
  end

  defp basin({x, y} = location, locations, basin_acc) do
    basin_acc = MapSet.put(basin_acc, location)

    adj_basins =
      for adjacent_location <- adjacent_coordinates({x, y}),
          height_at(locations, adjacent_location) > height_at(locations, location),
          height_at(locations, adjacent_location) != 9,
          height_at(locations, adjacent_location) != nil,
          !MapSet.member?(basin_acc, adjacent_location),
          do: basin(adjacent_location, locations, basin_acc)

    if Enum.empty?(adj_basins) do
      basin_acc
    else
      adj_basins
      |> Enum.reduce(&MapSet.union/2)
      |> MapSet.union(basin_acc)
    end
  end

  defp adjacent_coordinates({x, y}) do
    adjacent_deltas = [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]

    for {delta_x, delta_y} <- adjacent_deltas,
        x + delta_x >= 0 and y + delta_y >= 0,
        do: {x + delta_x, y + delta_y}
  end

  defp height_at(_, {x, y}) when x < 0 or y < 0, do: nil

  defp height_at(locations, {x, y}) do
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
