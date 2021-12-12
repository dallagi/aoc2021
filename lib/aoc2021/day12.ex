defmodule Aoc2021.Day12 do
  def part1(input) do
    input
    |> parse()
    |> paths_count()
  end

  def part2(input) do
    input
    |> parse()
    |> paths_count2()
  end

  defp paths_count(connections, position \\ "start", visited \\ MapSet.new()) do
    neighbors = Map.get(connections, position, [])

    if position == "end" do
      1
    else
      neighbors
      |> Enum.reject(&(&1 == "start"))
      |> Enum.reject(&(small_cave?(&1) and &1 in visited))
      |> Enum.map(&paths_count(connections, &1, MapSet.put(visited, position)))
      |> Enum.sum()
    end
  end

  defp paths_count2(
         connections,
         position \\ "start",
         visited \\ MapSet.new(),
         small_cave_visited_twice? \\ false
       ) do
    neighbors = Map.get(connections, position, [])

    if position == "end" do
      1
    else
      neighbors
      |> Enum.reject(&(&1 == "start"))
      |> Enum.map(fn neighbor ->
        cond do
          small_cave?(neighbor) and neighbor in visited and small_cave_visited_twice? ->
            0

          small_cave?(neighbor) and neighbor in visited ->
            paths_count2(connections, neighbor, MapSet.put(visited, position), true)

          true ->
            paths_count2(
              connections,
              neighbor,
              MapSet.put(visited, position),
              small_cave_visited_twice?
            )
        end
      end)
      |> Enum.sum()
    end
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
