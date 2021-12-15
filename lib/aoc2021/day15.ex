defmodule Aoc2021.Day15 do
  @cache __MODULE__.Cache

  def part1(input) do
    IO.puts("Starting...")
    cache = Agent.start_link(fn -> %{} end, name: @cache)
    map = parse(input)
    target = bottom_right_corner(map)

    dijkstra(map, {0, 0}, target)
  end

  def part2(input) do
    nil
  end

  def dijkstra(map, source, target) do
    to_visit = :gb_sets.singleton({0, source})

    dijkstra(map, source, target, to_visit, MapSet.new())
  end

  def dijkstra(map, source, target, to_visit, visited) do
    {{dist, node}, to_visit} = :gb_sets.take_smallest(to_visit)

    if node == target do
      dist
    else
      visited = MapSet.put(visited, node)

      to_visit =
        for neighbor <- neighbors_for(map, node, target),
            neighbor not in visited,
            priority = map[neighbor] + dist,
            reduce: to_visit do
          to_visit -> :gb_sets.add_element({priority, neighbor}, to_visit)
        end
      dijkstra(map, source, target, to_visit, visited)
    end
  end

  defp bottom_right_corner(map) do
    max_x = map |> Enum.map(fn {{x, _y}, _} -> x end) |> Enum.max()
    max_y = map |> Enum.map(fn {{_x, y}, _} -> y end) |> Enum.max()
    {max_x, max_y}
  end

  def neighbors_for(map, {x, y}, target) do
    adjacent_deltas = [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]
    {max_x, max_y} = target

    for {delta_x, delta_y} <- adjacent_deltas,
        {new_x, new_y} = {x + delta_x, y + delta_y},
        new_x >= 0 and new_y >= 0 and new_x <= max_x and new_y <= max_y,
        do: {new_x, new_y}
  end

  def parse(input) do
    for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
        {elem, x} <- row |> String.split("", trim: true) |> Enum.with_index(),
        into: %{},
        do: {{x, y}, String.to_integer(elem)}
  end
end
