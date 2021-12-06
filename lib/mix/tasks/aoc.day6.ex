defmodule Mix.Tasks.Aoc.Day6 do
  use Mix.Task

  alias Aoc2021.Day6

  def run(_args) do
    part1 = Day6.part1(Aoc2021.input_for("06"))
    IO.puts("Result for day6 part1: #{part1}")

    part2 = Day6.part2(Aoc2021.input_for("06"))
    IO.puts("Result for day6 part2: #{part2}")
  end
end
