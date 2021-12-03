defmodule Mix.Tasks.Aoc.Day3 do
  use Mix.Task

  alias Aoc2021.Day3

  def run(_args) do
    part1 = Day3.part1(Aoc2021.input_for("03"))
    IO.puts("Result for day3 part1: #{part1}")

    part2 = Day3.part2(Aoc2021.input_for("03"))
    IO.puts("Result for day3 part2: #{part2}")
  end
end
