defmodule Aoc2021.Day15 do
  def part1(input) do
    map = parse(input)
    target = bottom_right_corner(map)

    dijkstra(map, {0, 0}, target)
  end

  def part2(input) do
    map = parse(input)
    {max_x, max_y} = target = bottom_right_corner(map)

    new_map = enlarge(map, max_x, max_y)

    target = bottom_right_corner(new_map)
    dijkstra(new_map, {0, 0}, target)
  end

  defp dijkstra(map, source, target) do
    to_visit = :gb_sets.singleton({0, source})

    dijkstra(map, source, target, to_visit, MapSet.new())
  end

  defp dijkstra(map, source, target, to_visit, visited) do
    {{dist, node}, to_visit} = :gb_sets.take_smallest(to_visit)

    if node == target do
      dist
    else
      visited = MapSet.put(visited, node)

      to_visit =
        for neighbor <- neighbors_for(node, target),
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

  defp neighbors_for({x, y}, target) do
    adjacent_deltas = [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]
    {max_x, max_y} = target

    for {delta_x, delta_y} <- adjacent_deltas,
        {new_x, new_y} = {x + delta_x, y + delta_y},
        new_x >= 0 and new_y >= 0 and new_x <= max_x and new_y <= max_y,
        do: {new_x, new_y}
  end

  defp enlarge(map, max_x, max_y) do
    for x_factor <- 0..4,
        y_factor <- 0..4,
        reduce: map do
      new_map ->
        Map.merge(new_map, enlarged(map, x_factor, y_factor, max_x, max_y))
    end
  end

  defp enlarged(map, x_factor, y_factor, max_x, max_y) do
    for {{x, y}, risk} <- map, into: %{} do
      new_x = x + x_factor * (max_x + 1)
      new_y = y + y_factor * (max_y + 1)
      new_risk = risk + x_factor + y_factor
      new_risk = if new_risk <= 9, do: new_risk, else: new_risk - 9

      {{new_x, new_y}, new_risk}
    end
  end

  defp parse(input) do
    for {row, y} <- input |> String.split("\n", trim: true) |> Enum.with_index(),
        {elem, x} <- row |> String.split("", trim: true) |> Enum.with_index(),
        into: %{},
        do: {{x, y}, String.to_integer(elem)}
  end

  #   defp print(map, max_x, max_y) do
  #     for y <- 0..max_y,
  #         x <- 0..max_x do
  #       IO.write(map[{x, y}])
  #       if x == max_x, do: IO.puts("")
  #     end

  #     map
  #   end
end
