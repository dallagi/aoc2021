defmodule Mix.Tasks.Aoc.Day11 do
  use Mix.Task

  alias Aoc2021.Day11

  def run(_args) do
    part1 = Day11.part1(Aoc2021.input_for("11"))
    IO.puts("Result for day11 part1: #{part1}")

    part2 = Day11.part2(Aoc2021.input_for("11"))
    IO.puts("Result for day11 part2: #{part2}")
  end
end
