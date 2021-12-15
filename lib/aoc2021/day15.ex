defmodule Aoc2021.Day15 do
  @cache __MODULE__.Cache

  def part1(input) do
    IO.puts("Starting...")
    cache = Agent.start_link(fn -> %{} end, name: @cache)
    map = parse(input)

    {dist, prev} = dijkstra(map, {0, 0})

    dist[bottom_right_corner(map)]
  end

  def part2(input) do
    nil
  end

  def dijkstra(map, source) do
    dist =
      map
      |> Map.map(fn {location, _} -> {location, :infinity} end)
      |> Map.put(source, 0)

    prev = Map.map(map, fn {location, _} -> {location, :undefined} end)
    # TODO: switch to priority queue (do they exist for erlang?)
    queue = Map.keys(map)

    dijkstra(map, source, dist, prev, queue)
  end

  def dijkstra(map, source, dist, prev, queue) do
    case queue do
      [] ->
        {dist, prev}

      queue ->
        u = Enum.min_by(queue, fn loc -> dist[loc] end)

        rest = Enum.reject(queue, &(&1 == u))

        neighbors =
          for neighbor <- neighbors_for(map, u),
              neighbor in rest,
              alt = dist[u] + map[neighbor],
              alt < dist[neighbor],
              do: {neighbor, alt}

        dist_update = for {neighbor, alt} <- neighbors, into: %{}, do: {neighbor, alt}
        prev_update = for {neighbor, _} <- neighbors, into: %{}, do: {neighbor, u}

        dijkstra(map, source, Map.merge(dist, dist_update), Map.merge(prev, prev_update), rest)
    end
  end

  defp bottom_right_corner(map) do
    max_x = map |> Enum.map(fn {{x, _y}, _} -> x end) |> Enum.max()
    max_y = map |> Enum.map(fn {{_x, y}, _} -> y end) |> Enum.max()
    {max_x, max_y}
  end

  def neighbors_for(map, {x, y}) do
    adjacent_deltas = [{0, -1}, {-1, 0}, {0, 1}, {1, 0}]

    {max_x, max_y} = bottom_right_corner(map)

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
