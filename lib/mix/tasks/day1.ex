defmodule Mix.Tasks.Aoc.Day1 do
  use Mix.Task

  alias Aoc2021.Day1

  def run(_args) do
    part1 = Day1.part1(input_for(1))
    IO.puts("Result for day1 part1: #{part1}")

    part2 = Day1.part2(input_for(1))
    IO.puts("Result for day1 part2: #{part2}")
  end

  defp input_for(day) do
    path =
      Path.join([
        "priv",
        "inputs",
        String.pad_leading(to_string(day), 2, "0")
      ])
    File.read!(path)
  end
end
