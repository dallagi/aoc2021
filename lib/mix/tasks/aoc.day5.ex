defmodule Mix.Tasks.Aoc.Day5 do
  use Mix.Task

  alias Aoc2021.Day5

  def run(_args) do
    part1 = Day5.part1(Aoc2021.input_for("05"))
    IO.puts("Result for day5 part1: #{part1}")

    part2 = Day5.part2(Aoc2021.input_for("05"))
    IO.puts("Result for day5 part2: #{part2}")
  end
end
