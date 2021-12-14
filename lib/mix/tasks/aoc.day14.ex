defmodule Mix.Tasks.Aoc.Day14 do
  use Mix.Task

  alias Aoc2021.Day14

  def run(_args) do
    part1 = Day14.part1(Aoc2021.input_for("14"))
    IO.puts("Result for day14 part1: #{part1}")

    part2 = Day14.part2(Aoc2021.input_for("14"))
    IO.puts("Result for day14 part2: #{part2}")
  end
end
