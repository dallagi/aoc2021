defmodule Mix.Tasks.Aoc.Day18 do
  use Mix.Task

  alias Aoc2021.Day18

  def run(_args) do
    part1 = Day18.part1(Aoc2021.input_for("18"))
    IO.puts("Result for day18 part1: #{part1}")

    part2 = Day18.part2(Aoc2021.input_for("18"))
    IO.puts("Result for day18 part2: #{part2}")
  end
end
