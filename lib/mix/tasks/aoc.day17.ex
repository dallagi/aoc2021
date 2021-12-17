defmodule Mix.Tasks.Aoc.Day17 do
  use Mix.Task

  alias Aoc2021.Day17

  def run(_args) do
    part1 = Day17.part1(Aoc2021.input_for("17"))
    IO.puts("Result for day17 part1: #{part1}")

    part2 = Day17.part2(Aoc2021.input_for("17"))
    IO.puts("Result for day17 part2: #{part2}")
  end
end
