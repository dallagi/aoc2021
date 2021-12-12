defmodule Mix.Tasks.Aoc.Day12 do
  use Mix.Task

  alias Aoc2021.Day12

  def run(_args) do
    part1 = Day12.part1(Aoc2021.input_for("12"))
    IO.puts("Result for day12 part1: #{part1}")

    part2 = Day12.part2(Aoc2021.input_for("12"))
    IO.puts("Result for day12 part2: #{part2}")
  end
end
