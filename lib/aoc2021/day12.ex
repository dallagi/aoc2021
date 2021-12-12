defmodule Aoc2021.Day12 do
  def part1(input) do
    parse(input)

    input
    |> parse()
    |> paths_count()
  end

  def part2(input) do
    nil
  end

  defp paths_count(connections, position \\ "start", visited \\ MapSet.new()) do
    neighbors = Map.get(connections, position, [])

    if position == "end" do
      1
    else
      neighbors
      |> Enum.reject(&(small_cave?(&1) and &1 in visited))
      |> Enum.map(&paths_count(connections, &1, MapSet.put(visited, position)))
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
