defmodule Aoc2021.Day12 do
  def part1(input) do
    input
    |> parse()
    |> paths_count(false)
  end

  def part2(input) do
    input
    |> parse()
    |> paths_count(true)
  end

  defp paths_count(
         connections,
         can_visit_small_cave_twice?,
         position \\ "start",
         visited \\ MapSet.new()
       )

  defp paths_count(_, _, "end", _), do: 1

  defp paths_count(connections, can_visit_small_cave_twice?, position, visited) do
    neighbors = Map.get(connections, position, [])

    neighbors
    |> Enum.reject(&(&1 == "start"))
    |> Enum.map(fn neighbor ->
      cond do
        small_cave?(neighbor) and neighbor in visited and can_visit_small_cave_twice? ->
          paths_count(connections, false, neighbor, MapSet.put(visited, position))

        small_cave?(neighbor) and neighbor in visited ->
          0

        true ->
          paths_count(
            connections,
            can_visit_small_cave_twice?,
            neighbor,
            MapSet.put(visited, position)
          )
      end
    end)
    |> Enum.sum()
  end

  defp small_cave?(cave), do: cave =~ ~r/[a-z]+/

  defp parse(input) do
    for row <- String.split(input, "\n", trim: true), reduce: %{} do
      connections ->
        [from, to] = String.split(row, "-", parts: 2)

        connections
        |> Map.update(from, [to], fn dests -> [to | dests] end)
        |> Map.update(to, [from], fn dests -> [from | dests] end)
    end
  end
end
