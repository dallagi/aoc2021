defmodule Mix.Tasks.Aoc.Day9 do
  use Mix.Task

  alias Aoc2021.Day9

  def run(_args) do
    part1 = Day9.part1(Aoc2021.input_for("09"))
    IO.puts("Result for day9 part1: #{part1}")

    part2 = Day9.part2(Aoc2021.input_for("09"))
    IO.puts("Result for day9 part2: #{part2}")
  end
end
