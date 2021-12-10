defmodule Mix.Tasks.Aoc.Day10 do
  use Mix.Task

  alias Aoc2021.Day10

  def run(_args) do
    part1 = Day10.part1(Aoc2021.input_for("10"))
    IO.puts("Result for day10 part1: #{part1}")

    part2 = Day10.part2(Aoc2021.input_for("10"))
    IO.puts("Result for day10 part2: #{part2}")
  end
end
