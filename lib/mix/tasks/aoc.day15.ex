defmodule Mix.Tasks.Aoc.Day15 do
  use Mix.Task

  alias Aoc2021.Day15

  def run(_args) do
    part1 = Day15.part1(Aoc2021.input_for("15"))
    IO.puts("Result for day15 part1: #{part1}")

    part2 = Day15.part2(Aoc2021.input_for("15"))
    IO.puts("Result for day15 part2: #{part2}")
  end
end
