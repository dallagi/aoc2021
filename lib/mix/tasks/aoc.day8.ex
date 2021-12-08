defmodule Mix.Tasks.Aoc.Day8 do
  use Mix.Task

  alias Aoc2021.Day8

  def run(_args) do
    part1 = Day8.part1(Aoc2021.input_for("08"))
    IO.puts("Result for day8 part1: #{part1}")

    part2 = Day8.part2(Aoc2021.input_for("08"))
    IO.puts("Result for day8 part2: #{part2}")
  end
end
